Puppet::Type.type(:lxc).provide(:container) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  attr_accessor :container, :lxc_version

  def create
    unless @container
      @container = LXC::Container.new(@resource[:name])
    end

    begin
      @container.create(@resource[:template], @resource[:storage_backend].to_s, symbolize_hash(@resource[:storage_options]))
    rescue StandardError => e
      fail("Failed to create #{@resource[:name]}: #{e.message}")
    end

    begin
      unless @resource[:ipv4].nil?
        @container.set_config_item('lxc.network.0.ipv4',@resource[:ipv4])
        @container.set_config_item('lxc.network.0.ipv4_gateway',@resource[:ipv4_gateway]) unless @resource[:ipv4_gateway].nil?
        @container.save_config
      end
    rescue LXC::Error => e
      fail("Failed to set networking settings: #{e.message}")
    end

    case @resource[:state]
    when :running
      self.start
    when :frozen
      self.start
      self.frozen
    end

  end

  def exists?
    unless @container
      @container = LXC::Container.new(@resource[:name])
    end
    @container.defined?
  end

  def destroy
    unless @container
      @container = LXC::Container.new(@resource[:name])
    end

    case self.status
    when :running
      self.stop
    when :frozen
      self.unfreeze
      self.stop
    end

    begin
      @container.destroy
    rescue StandardError => e
      fail("Failed to destroy #{@resource[:name]}: #{e.message}")
    end
    true
  end

  def start
    unless @container
      @container = LXC::Container.new(@resource[:name])
    end
    begin
      if self.status == :frozen
        self.unfreeze
      else
        @container.start
      end
      @container.wait(:running, @resource[:timeout])
    rescue StandardError => e
      fail("Failed to start #{@resource[:name]}: #{e.message}")
    end
    true
  end

  def stop
    unless @container
      @container = LXC::Container.new(@resource[:name])
    end

    begin
      @container.stop
      @container.wait(:stopped, @resource[:timeout])
    rescue StandardError => e
      fail("Failed to stop #{@resource[:name]}: #{e.message}")
    end
    true
  end

  def freeze
    unless @container
      @container = LXC::Container.new(@resource[:name])
    end

    begin
      unless self.status == :frozen
        @container.freeze
        @container.wait(:frozen, @resource[:timeout])
      end
    rescue StandardError => e
      fail("Failed to freeze #{@resource[:name]}: #{e.message}")
    end
    true
  end

  def unfreeze
    unless @container
      @container = LXC::Container.new(@resource[:name])
    end

    begin
      if self.status == :frozen
        @container.unfreeze
        @container.wait(:running, @resource[:timeout])
      end
    rescue StandardError => e
      fail("Failed to unfreeze #{@resource[:name]}: #{e.message}")
    end
    true
  end

  def status
    unless @container
      @container = LXC::Container.new(@resource[:name])
    end
    @container.state
  end

  def ipv4
    begin
      # This is a workaround until liblxc is realease with
      # https://github.com/lxc/lxc/pull/332
      # Once liblxc >= 1.1.0, LXC::version can be used to call the proper method
      # hopefull the patch will be there for 1.1.0
      unless @container
        @container = LXC::Container.new(@resource[:name])
      end

      unless @lxc_version
        @lxc_version = LXC::version
      end

      if Puppet::Util::Package.versioncmp(@lxc_version,"1.1.0") < 0
        fd = File.new(@container.config_file_name,'r')
        content = fd.readlines
        fd.close
        matched = content.select { |c| c =~ /lxc.network/ }
        index = matched.rindex("lxc.network.name = eth0\n")
        sliced = matched.slice(index..-1)
        sliced.select { |m| m =~ /lxc.network.ipv4/ }.first.split('=').last.strip
      else
        @container.config_item("lxc.network.0.ipv4").first
      end
    rescue StandardError
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def ipv4=(value)
    begin
      unless @container
        @container = LXC::Container.new(@resource[:name])
      end

      @container.clear_config_item("lxc.network.0.ipv4")
      @container.set_config_item("lxc.network.0.ipv4",value)
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  private
  def symbolize_hash hash
    result = {}
    if hash.nil?
      return nil
    else
      hash.each do |k,v|
        if v.kind_of?Hash
          result[k.to_sym] = self.symbolize_hash v
        else
          result[k.to_sym] = k == 'fssize' ? v.to_i : v
        end
      end
    end
    result
  end
end

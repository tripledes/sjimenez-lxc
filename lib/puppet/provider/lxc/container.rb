Puppet::Type.type(:lxc).provide(:container) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  attr_accessor :container, :lxc_version

  def create
    unless @container
      @container = LXC::Container.new(@resource[:name])
    end

    begin
      @container.create(@resource[:template], @resource[:storage_backend].to_s, symbolize_hash(@resource[:storage_options]),0,@resource[:template_options])
    rescue LXC::Error => e
      fail("Failed to create #{@resource[:name]}: #{e.message}")
    end

    @container.save_config

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

  private
  def restart
    self.stop
    self.start
  end

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

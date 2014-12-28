Puppet::Type.type(:lxc).provide(:container) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  attr_accessor :container, :lxc_version

  def create
    define_container

    begin
      @container.create(@resource[:template], @resource[:storage_backend].to_s, symbolize_hash(@resource[:storage_options]),0,@resource[:template_options])
      @container.set_config_item('lxc.start.auto','1') if @resource[:autostart]
      @container.set_config_item('lxc.start.delay',@resource[:autostart_delay]) if not @resource[:autostart_delay].nil?
      @container.set_config_item('lxc.start.order',@resource[:autostart_order]) if not @resource[:autostart_order].nil?
      @container.set_config_item('lxc.group',@resource[:groups]) if @resource[:groups].kind_of?Array
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
    define_container
    @container.defined?
  end

  def destroy
    define_container

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
    begin
      define_container
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
    begin
      define_container
      @container.stop
      @container.wait(:stopped, @resource[:timeout])
    rescue StandardError => e
      fail("Failed to stop #{@resource[:name]}: #{e.message}")
    end
    true
  end

  def freeze
    begin
      define_container
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
    begin
      define_container
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
    begin
      define_container
      @container.state
    rescue LXC::Error
      ""
    end
  end

  # Getters/setters
  def autostart
    begin
      define_container
      return :true if @container.config_item('lxc.start.auto') == '1'
      return :false
    rescue LXC::Error
      ""
    end
  end

  def autostart=(value)
    begin
      define_container
      @container.clear_config_item('lxc.start.auto')
      case value
      when :true
        @container.set_config_item('lxc.start.auto','1')
      else
        @container.set_config_item('lxc.start.auto','0')
      end
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def autostart_delay
    begin
      define_container
      @container.config_item('lxc.start.delay')
    rescue LXC::Error
      ""
    end
  end

  def autostart_delay=(value)
    begin
      define_container
      @container.clear_config_item('lxc.start.delay')
      @container.set_config_item('lxc.start.delay',value)
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def autostart_order
    begin
      define_container
      @container.config_item('lxc.start.order')
    rescue LXC::Error
      ""
    end
  end

  def autostart_order=(value)
    begin
      define_container
      @container.clear_config_item('lxc.start.order')
      @container.set_config_item('lxc.start.order',value)
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def groups
    begin
      define_container
      @container.config_item('lxc.group')
    rescue LXC::Error
      ""
    end
  end

  def groups=(value)
    begin
      define_container
      @container.set_config_item('lxc.group',value)
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  private
  def define_container
    unless @container
      @container = LXC::Container.new(@resource[:name])
    end
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

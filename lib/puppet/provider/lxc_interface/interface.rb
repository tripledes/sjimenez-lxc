Puppet::Type.type(:lxc_interface).provide(:interface) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  attr_accessor :container

  def create
    begin
      define_container
      @container.set_config_item("lxc.network.#{@resource[:index]}.type", @resource[:type])
      @container.set_config_item("lxc.network.#{@resource[:index]}.name", @resource[:name])
      @container.set_config_item("lxc.network.#{@resource[:index]}.link", @resource[:link]) unless @resource[:link].nil?
      @container.set_config_item("lxc.network.#{@resource[:index]}.vlan_id", @resource[:vlan_id]) unless @resource[:vlan_id].nil?
      @container.set_config_item("lxc.network.#{@resource[:index]}.macvlan_mode", @resource[:macvlan_mode]) unless @resource[:macvlan_mode].nil?
      @container.set_config_item("lxc.network.#{@resource[:index]}.ipv4", @resource[:ipv4]) unless @resource[:ipv4].nil?
      @container.set_config_item("lxc.network.#{@resource[:index]}.hwaddr", @resource[:hwaddr]) unless @resource[:hwaddr].nil?
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def exists?
    begin
      define_container
      @container.keys("lxc.network.#{@resource[:index]}")
      true
    rescue LXC::Error
      false
    end
  end

  def destroy
    begin
      define_container
      @container.keys("lxc.network.#{@resource[:index]}").each do |k|
        @container.clear_config_item("lxc.network.#{@resource[:index]}.#{k}")
      end
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def define_container
    unless @container
      @container = LXC::Container.new(@resource[:container])
    end
  end

  # getters and setters

  def link
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.link")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def link=(value)
    begin
      define_container
      @container.set_config_item("lxc.network.#{@resource[:index]}.link",value)
      true
    rescue LXC::Error
      false
    end
  end

  def vlan_id
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.vlan_id")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def vlan_id=(value)
    begin
      define_container
      @container.set_config_item("lxc.network.#{@resource[:index]}.vlan_id",value)
      true
    rescue LXC::Error
      false
    end
  end

  def macvlan_mode
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.macvlan_mode")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def macvlan_mode=(value)
    begin
      define_container
      @container.set_config_item("lxc.network.#{@resource[:index]}.macvlan_mode",value)
      true
    rescue LXC::Error
      false
    end
  end

  def type
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.type")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def type=(value)
    begin
      define_container
      @container.set_config_item("lxc.network.#{@resource[:index]}.type",value)
      true
    rescue LXC::Error
      false
    end
  end

  def ipv4
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.ipv4")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def ipv4=(value)
    begin
      define_container
      @container.set_config_item("lxc.network.#{@resource[:index]}.ipv4",value)
      true
    rescue LXC::Error
      false
    end
  end

  def hwaddr
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.hwaddr")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def hwaddr=(value)
    begin
      define_container
      @container.set_config_item("lxc.network.#{@resource[:index]}.hwaddr",value)
      true
    rescue LXC::Error
      false
    end
  end
end

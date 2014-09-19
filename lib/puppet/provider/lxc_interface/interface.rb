Puppet::Type.type(:lxc_interface).provide(:interface) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  attr_accessor :container

  def create
    begin
      define_container
      @container.set_config_item("lxc.network.#{@resource[:index]}.name", @resource[:name])
      @container.set_config_item("lxc.network.#{@resource[:index]}.flags", @resource[:flags])
      @container.set_config_item("lxc.network.#{@resource[:index]}.type", @resource[:type])
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
  end

  def define_container
    unless @container
      @container = LXC::Container.new(@resource[:container])
    end
  end
end

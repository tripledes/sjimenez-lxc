require 'ipaddr'

Puppet::Type.newtype(:lxc_interface) do
  @doc = 'LXC interface manages network interfaces in a container'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'Interface name'
  end

  newparam(:container) do
    desc 'Name of the container'
  end

  newproperty(:link) do
    desc 'Host interface where to link the container interface'
  end

  newproperty(:flags) do
    desc 'Flags to set on the interface'
    validate do |value|
      # do more flags exist?
      unless ['up', 'down'].include?value
        raise ArgumentError, 'Invalid flag, only up or down are allowed'
      end
    end
  end

  newproperty(:vlan_id) do
    desc 'VLAN ID to use with network type is vlan'
    validate do |value|
      unless value =~ /d+/
        raise ArgumentError, 'Invalid VLAN ID, it is not numeric'
      end
    end
  end

  newproperty(:macvlan_mode) do
    desc 'macvlan mode'
    validate do |value|
      unless ['private','vepa','bridge'].include?value
        raise ArgumentError, 'Invalid macvlan mode'
      end
    end
  end

  newproperty(:type) do
    desc 'Network type'
    validate do |value|
      unless ['veth', 'vlan', 'macvlan', 'phys'].include?value
        raise ArgumentError, 'Invalid network type'
      end

      raise ArgumentError, 'Missing VLAN ID' if @resource[:vlan_id].nil? and value == 'vlan'
      raise ArgumentError, 'Missing link, needed for macvlan' if @resource[:link].nil? and value == 'macvlan'
      raise ArgumentError, 'Missing macvlan_mode' if @resource[:macvlan_mode].nil? and value == 'macvlan'
    end
  end

  newproperty(:ipv4) do
    desc 'IPv4 address'
    validate do |value|
      begin
        ip = IPAddr.new(value)
      rescue ArgumentError
        raise ArgumentError, 'Invalid IPv4 address'
      end
    end
  end

  newproperty(:hwaddr) do
    desc 'MAC address for the interface'
    validate do |value|
      unless value =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
        raise ArgumentError, 'Invalid hardware address'
      end
    end
  end

  autorequire(:lxc) do
    [@resource[:container]]
  end
end

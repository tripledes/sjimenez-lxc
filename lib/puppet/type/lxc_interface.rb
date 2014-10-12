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

  newparam(:index) do
    desc 'Index for interface configuration'
    newvalues(/[1-9]+/)
  end

  newproperty(:link) do
    desc 'Host interface where to link the container interface'
  end

  newproperty(:vlan_id) do
    desc 'VLAN ID to use with network type is vlan'
    validate do |value|
      unless value =~ /\d+/
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
    defaultto 'veth'
    validate do |value|
      unless ['veth', 'vlan', 'macvlan', 'phys'].include?value
        raise ArgumentError, 'Invalid network type'
      end

      raise ArgumentError, 'Missing VLAN ID' if @resource[:vlan_id].nil? and value == 'vlan'
      raise ArgumentError, 'Missing link, needed for macvlan' if @resource[:link].nil? and value == 'macvlan'
      raise ArgumentError, 'Missing macvlan_mode' if @resource[:macvlan_mode].nil? and value == 'macvlan'
    end
  end

  newproperty(:ipv4, :array_matching => :all) do
    desc 'IPv4 address'
    validate do |value|
      ips = Array.new

      case value.class.to_s
      when 'String'
        ips << value
      when 'Array'
        ips = value
      else
        raise ArgumentError, 'ipv4 parameter must be either String or Array'
      end

      ips.each do |ip|
        begin
          IPAddr.new(ip)
        rescue ArgumentError
          raise ArgumentError, 'Invalid IPv4 address'
        end
      end
    end
    munge do |value|
      if value.kind_of?String
        Array.new.push(value)
      else
        value
      end
    end
    def insync?(is)
      self.devfail "#{self.class.name}'s should is not array" unless @should.is_a?(Array)
      return true if @should.empty?
      return (is == @should.flatten or is == @should.collect { |v| v.to_s }) if match_all?
      @should.each { |val| return true if is == val or is == val.to_s }
      false
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

  newparam(:restart) do
    defaultto false
    newvalues(:true,:false)
  end

  autorequire(:lxc) do
    [self[:container]]
  end

  validate do
    raise ArgumentError, 'Index parameter is required' if self[:index].nil?
    raise ArgumentError, 'Container parameter is required' if self[:container].nil?
  end
end

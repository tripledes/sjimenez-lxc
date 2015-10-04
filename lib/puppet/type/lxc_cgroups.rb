Puppet::Type.newtype(:lxc_cgroups) do
  @doc = 'LXC cgroups manages container limits'

  newproperty(:value) do
    desc 'Value for limit'
    validate do |value|
      unless value.kind_of?String
        raise ArgumentError, "Wrong value type: #{value.class}"
      end
    end
  end

  newparam(:container) do
    desc 'Container name'
    validate do |value|
      unless value.kind_of?String
        raise ArgumentError, "Wrong container name: #{value.class}"
      end
    end
  end

  newparam(:name, :namevar => true) do
    desc 'Cgroup limit name'
    validate do |value|
      controller = value.split('.').first
      unless ['cpuset','cpu','cpuacct','memory','devices','freezer','net_cls','blkio','perf_event','net_prio','hugetlb'].member?controller
        raise ArgumentError, "Wrong controller: #{controller}"
      end
    end
  end

  autorequire(:lxc) do
    self[:container]
  end
end

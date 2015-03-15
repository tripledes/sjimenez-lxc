Puppet::Type.newtype(:lxc_cgroups) do
  @doc = 'LXC cgroups manages container limits'

  newproperty(:ensure) do
    desc 'Ensure state'
    newvalues :present
  end

  newproperty(:value) do
    desc 'Value for limit'
    newvalues(/\s/)
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
end

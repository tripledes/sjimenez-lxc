Puppet::Type.newtype(:lxc) do
  @doc = 'LXC management'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'Name for the container.'
  end

  newparam(:template) do
    desc 'Template on which the container will be based.'
  end

  newparam(:timeout) do
    desc 'Timeout in seconds for container operations.'
    defaultto 10
  end

  newparam(:storage_backend) do
    desc 'Storage backend type for the container.'
    defaultto :dir
    newvalues(:dir, :lvm, :btrfs, :loop, :best)
  end

  newparam(:storage_options) do
    desc 'Options for the storage backend.'

    validate do |value|
      unless value.kind_of?Hash
        fail('storage_options is not a Hash')
      end

      value.keys.each do |k|
         fail("#{k} is not a valid storage option") unless ['dir', 'lvname', 'vgname', 'thinpool', 'fstype', 'fssize'].include?k
      end
    end
  end

  newproperty(:state) do
    desc 'Whether a container should be running, stopped or frozen.'

    defaultto :running

    newvalue(:running, :event => :container_started) do
      provider.start
    end

    newvalue(:stopped, :event => :container_stopped) do
      provider.stop
    end

    newvalue(:frozen, :event => :container_frozen) do
      provider.freeze
    end

    def retrieve
      provider.status
    end

  end

  autorequire(:package) do
    ['lxc-bindings']
  end
end


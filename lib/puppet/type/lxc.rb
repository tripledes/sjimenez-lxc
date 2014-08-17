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

  newproperty(:state) do
    desc 'Whether a container should be running, stopped, frozen or absent.'

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
end


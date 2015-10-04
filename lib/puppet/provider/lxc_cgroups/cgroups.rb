Puppet::Type.type(:lxc_cgroups).provide(:cgroups) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  attr_accessor :container

  def value
    begin
      define_container
      return @container.cgroup_item(@resource[:name])
    rescue LXC::Error => e
      Puppet.debug(e.message)
      return false
    end
  end

  def value=(value)
    begin
      define_container
      @container.set_cgroup_item(@resource[:name], @resource[:value])
    rescue LXC::Error => e
      Puppet.debug(e.message)
      return false
    end
    @container.cgroup_item(@resource[:name])
  end

  private
  def define_container
    begin
      unless @container
        @container = LXC::Container.new(@resource[:container])
      end
    rescue LXC::Error => e
      Puppet.debug("Error with container #{@resource[:container]}")
      Puppet.err(e.message)
      return false
    end
  end
end

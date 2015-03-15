Puppet::Type.type(:lxc_cgroups).provide(:cgroups) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  attr_accessor :container

  def create
    begin
      define_container
      @container.set_cgroup_item(@resource[:name], @resource[:value])
      true
    rescue LXC::Error => e
      Puppet.debug(e.message)
      false
    end
  end

  def exists?
    begin
      define_container
      return true if @container.cgroup_item(@resource[:name]).eql?(@resource[:value])
    rescue LXC::Error => e
      Puppet.debug(e.message)
      return false
    end
    false
  end

  def destroy
    # TODO: find a way to restore default value, memory controller
    # allows to set value -1, hopefull all other will have a similar
    # way.
    true
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

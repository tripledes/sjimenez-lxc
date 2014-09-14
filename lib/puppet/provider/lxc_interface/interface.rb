Puppet::Type.type(:lxc_interface).provide(:interface) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  attr_accessor :container

  def create
  end

  def exists?
    define_container
    begin
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

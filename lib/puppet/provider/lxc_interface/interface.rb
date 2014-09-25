Puppet::Type.type(:lxc_interface).provide(:interface) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  attr_accessor :container

  def create
    begin
      define_container
      @container.set_config_item("lxc.network.#{@resource[:index]}.type", @resource[:type])
      @container.set_config_item("lxc.network.#{@resource[:index]}.name", @resource[:name])
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
    begin
      define_container
      @container.keys("lxc.network.#{@resource[:index]}").each do |k|
        @container.clear_config_item("lxc.network.#{@resource[:index]}.#{k}")
      end
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def define_container
    unless @container
      @container = LXC::Container.new(@resource[:container])
    end
  end

  # getters and setters

  def link
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.link")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def link=(value)
    begin
      define_container
      @container.clear_config_item("lxc.network.#{@resource[:index]}.link")
      @container.set_config_item("lxc.network.#{@resource[:index]}.link",value)
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def vlan_id
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.vlan_id")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def vlan_id=(value)
    begin
      define_container
      @container.clear_config_item("lxc.network.#{@resource[:index]}.vlan_id")
      @container.set_config_item("lxc.network.#{@resource[:index]}.vlan_id",value)
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def macvlan_mode
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.macvlan_mode")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def macvlan_mode=(value)
    begin
      define_container
      @container.clear_config_item("lxc.network.#{@resource[:index]}.macvlan_mode")
      @container.set_config_item("lxc.network.#{@resource[:index]}.macvlan_mode",value)
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def type
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.type")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def type=(value)
    begin
      define_container
      @container.clear_config_item("lxc.network.#{@resource[:index]}.type")
      @container.set_config_item("lxc.network.#{@resource[:index]}.type",value)
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def ipv4
    begin
      # This is a workaround until liblxc is realease with
      # https://github.com/lxc/lxc/pull/332
      # Once liblxc > 1.0.5, LXC::version can be used to call the proper method
      define_container
      if Puppet::Util::Package.versioncmp(LXC::version,"1.0.5") <= 0
        fd = File.new(@container.config_file_name,'r')
        content = fd.readlines
        fd.close
        matched = content.select { |c| c =~ /lxc.network/ }
        index = matched.rindex("lxc.network.name = #{@resource[:name]}\n")
        sliced = matched.slice(index..-1)
        sliced.select { |m| m =~ /lxc.network.ipv4/ }.first.split('=').last.strip
      else
        @container.config_item("lxc.network.#{@resource[:index]}.ipv4").first
      end
    rescue StandardError
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def ipv4=(value)
    begin
      define_container
      @container.clear_config_item("lxc.network.#{@resource[:index]}.ipv4")
      @container.set_config_item("lxc.network.#{@resource[:index]}.ipv4",value)
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end

  def hwaddr
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.hwaddr")
    rescue LXC::Error
      # TODO: might be better to fail here instead of returning empty string which
      # would trigger the setter
      ""
    end
  end

  def hwaddr=(value)
    begin
      define_container
      @container.clear_config_item("lxc.network.#{@resource[:index]}.hwaddr")
      @container.set_config_item("lxc.network.#{@resource[:index]}.hwaddr",value)
      @container.save_config
      true
    rescue LXC::Error
      false
    end
  end
end

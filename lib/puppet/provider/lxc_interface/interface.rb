Puppet::Type.type(:lxc_interface).provide(:interface) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  attr_accessor :container, :lxc_version

  def create
    begin
      define_container
      @container.set_config_item("lxc.network.#{@resource[:index]}.type", @resource[:type])
      @container.set_config_item("lxc.network.#{@resource[:index]}.name", @resource[:device_name])
      @container.set_config_item("lxc.network.#{@resource[:index]}.link", @resource[:link]) unless @resource[:link].nil?
      @container.set_config_item("lxc.network.#{@resource[:index]}.vlan_id", @resource[:vlan_id]) unless @resource[:vlan_id].nil?
      @container.set_config_item("lxc.network.#{@resource[:index]}.macvlan_mode", @resource[:macvlan_mode]) unless @resource[:macvlan_mode].nil?
      @container.set_config_item("lxc.network.#{@resource[:index]}.ipv4", @resource[:ipv4].flatten) unless @resource[:ipv4].nil?
      @container.set_config_item("lxc.network.#{@resource[:index]}.hwaddr", @resource[:hwaddr]) unless @resource[:hwaddr].nil?
      @container.save_config
      restart if @resource[:restart]
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
      @container.clear_config_item("lxc.network.#{@resource[:index]}")
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

  def device_name
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.name")
    rescue LXC::Error
      ""
    end
  end

  def device_name=(value)
    begin
      define_container
      @container.clear_config_item("lxc.network.#{@resource[:index]}.name")
      @container.set_config_item("lxc.network.#{@resource[:index]}.name",value)
      @container.save_config
      restart if @resource[:restart]
      true
    rescue LXC::Error
      false
    end
  end

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
      restart if @resource[:restart]
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
      restart if @resource[:restart]
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
      restart if @resource[:restart]
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
      restart if @resource[:restart]
      true
    rescue LXC::Error
      false
    end
  end

  def ipv4
    begin
      # This is a workaround until liblxc is realease with
      # https://github.com/lxc/lxc/pull/332
      # Once liblxc >= 1.1.0, LXC::version can be used to call the proper method
      # hopefull the patch will be there for 1.1.0
      define_container

      unless @lxc_version
        @lxc_version = LXC::version
      end

      if Puppet::Util::Package.versioncmp(@lxc_version,"1.1.0") < 0
        fd = File.new(@container.config_file_name,'r')
        content = fd.readlines
        fd.close
        matched = content.select { |c| c =~ /lxc.network/ }
        index = matched.rindex("lxc.network.name = #{@resource[:device_name]}\n")
        sliced = matched.slice(index..-1)
        # shift first lxc.network.name which should be the one we're handling.
        sliced.shift
        next_block_idx = sliced.index(sliced.grep(/lxc.network.name/).first)
        if next_block_idx.nil?
          ips = sliced
        else
          ips = sliced[0..(next_block_idx - 1)]
        end
        aux = ips.select { |b| b =~ /lxc.network.ipv4 =/ }
        aux.collect { |m| m.split('=').last.strip }
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
      # Why does it get an arrays of arrays?
      @container.set_config_item("lxc.network.#{@resource[:index]}.ipv4",value.flatten)
      @container.save_config
      restart if @resource[:restart]
      true
    rescue LXC::Error
      false
    end
  end

  # TODO: There is an inconsistency in liblxc, https://github.com/lxc/lxc/pull/337
  # thus, ipv4_gateway should detect version and work properly if the PR gets merged in.
  def ipv4_gateway
    begin
      define_container
      @container.config_item("lxc.network.#{@resource[:index]}.ipv4_gateway")
    rescue LXC::Error
      ""
    end
  end

  def ipv4_gateway=(value)
    begin
      define_container
      @container.clear_config_item("lxc.network.#{@resource[:index]}.ipv4_gateway")
      @container.set_config_item("lxc.network.#{@resource[:index]}.ipv4.gateway",value)
      @container.save_config
      restart if @resource[:restart]
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
      restart if @resource[:restart]
      true
    rescue LXC::Error
      false
    end
  end

  private
  def restart
    # TODO: make timeout a parameter defaultto 10
    @container.stop
    @container.wait(:stopped, 10)
    @container.start
    @container.wait(:running, 10)
  end
end

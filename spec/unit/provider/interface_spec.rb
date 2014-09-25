require 'spec_helper'
require 'lxc'

describe Puppet::Type.type(:lxc_interface).provider(:interface), 'basic interface definition' do

  before(:each) do
    @resource = Puppet::Type.type(:lxc_interface).new(
      {
         :name      => 'eth1',
         :container => 'lol_container',
         :index     => 1,
      }
    )
    @provider = Puppet::Type.type(:lxc_interface).provider(:interface).new(@resource)
    @provider.container = stub('LXC::Container')
  end

  describe '#exists?' do
    it 'should return false' do
      @provider.container.stubs(:keys).raises(LXC::Error)
      @provider.send(:exists?).should == false
    end
    it 'should return true when the interface exists' do
      @provider.container.stubs(:keys).returns(['name','hwaddr','ipv4','link','type'])
      @provider.send(:exists?).should == true
    end
  end

  describe '#create' do
    it 'should return true when settings are applied successfully' do
      @provider.container.stubs(:save_config)
      @provider.container.stubs(:set_config_item)
      @provider.send(:create).should == true
    end
    it 'should return false when LXC::Error is raised' do
      @provider.container.stubs(:set_config_item).raises(LXC::Error)
      @provider.send(:create).should == false
    end
  end

  describe '#destroy' do
    it 'should return true after successfully removing all items' do
      @provider.container.stubs(:keys).returns(['name','hwaddr','ipv4','link','type'])
      @provider.container.stubs(:clear_config_item)
      @provider.container.stubs(:save_config)
      @provider.send(:destroy).should == true
    end
    it 'should return false when LXC::Error is raised' do
      @provider.container.stubs(:keys).returns(['name','hwaddr','ipv4','link','type'])
      @provider.container.stubs(:clear_config_item).raises(LXC::Error)
      @provider.send(:destroy).should == false
    end
  end

  describe '#link' do
    it 'should return lxcbr0 from the getter' do
      @provider.container.stubs(:config_item).with('lxc.network.1.link').returns('lxcbr0')
      @provider.send(:link).should == 'lxcbr0'
    end
    it 'should return true when the setter successfully changes the value' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.link')
      @provider.container.stubs(:set_config_item).with('lxc.network.1.link','lxcbr1')
      @provider.container.stubs(:save_config)
      @provider.send(:link=,'lxcbr1').should == true
    end
    it 'setter should return false if LXC::Error is raised' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.link')
      @provider.container.stubs(:set_config_item).raises(LXC::Error)
      @provider.send(:link=,'lxcbr1').should == false
    end
  end

  describe '#vlan_id' do
    it 'should return 55 from the getter' do
      @provider.container.stubs(:config_item).with('lxc.network.1.vlan_id').returns('55')
      @provider.send(:vlan_id).should == '55'
    end
    it 'should return true when the setter successfully changes the value' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.vlan_id')
      @provider.container.stubs(:set_config_item).with('lxc.network.1.vlan_id','66')
      @provider.container.stubs(:save_config)
      @provider.send(:vlan_id=,'66').should == true
    end
    it 'setter should return false if LXC::Error is raised' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.vlan_id')
      @provider.container.stubs(:set_config_item).raises(LXC::Error)
      @provider.send(:vlan_id=,'66').should == false
    end
  end

  describe '#macvlan_mode' do
    it 'should return vepa from the getter' do
      @provider.container.stubs(:config_item).with('lxc.network.1.macvlan_mode').returns('vepa')
      @provider.send(:macvlan_mode).should == 'vepa'
    end
    it 'should return true when the setter successfully changes the value' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.macvlan_mode')
      @provider.container.stubs(:set_config_item).with('lxc.network.1.macvlan_mode','private')
      @provider.container.stubs(:save_config)
      @provider.send(:macvlan_mode=,'private').should == true
    end
    it 'setter should return false if LXC::Error is raised' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.macvlan_mode')
      @provider.container.stubs(:set_config_item).raises(LXC::Error)
      @provider.send(:macvlan_mode=,'bridge').should == false
    end
  end

  describe '#type' do
    it 'should return phys from the getter' do
      @provider.container.stubs(:config_item).with('lxc.network.1.type').returns('phys')
      @provider.send(:type).should == 'phys'
    end
    it 'should return true when the setter successfully changes the value' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.type')
      @provider.container.stubs(:set_config_item).with('lxc.network.1.type','macvlan')
      @provider.container.stubs(:save_config)
      @provider.send(:type=,'macvlan').should == true
    end
    it 'setter should return false if LXC::Error is raised' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.type')
      @provider.container.stubs(:set_config_item).raises(LXC::Error)
      @provider.send(:type=,'bridge').should == false
    end
  end

  describe '#ipv4' do
    it 'should return 192.168.1.100/24 from the getter', pending: "Have to stub File#methods" do
      @provider.container.stubs(:config_file_name).returns('/var/lib/lxc/ubuntu_test/config')
      @provider.fd = stub('File')
      @provider.fd.stubs(:readlines).returns(["lxc.network.name = eth1\n", "lxc.network.ipv4 = 192.168.1.100/24\n", "lxc.network.type = veth\n", "lxc.network.ipv4 = 101.101.101.2/16\n"])
      @provider.send(:ipv4).should == '192.168.1.100/24'
    end
    it 'should return true when the setter successfully changes the value' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.ipv4')
      @provider.container.stubs(:set_config_item).with('lxc.network.1.ipv4','192.168.1.101/24')
      @provider.container.stubs(:save_config)
      @provider.send(:ipv4=,'192.168.1.101/24').should == true
    end
    it 'setter should return false if LXC::Error is raised' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.ipv4')
      @provider.container.stubs(:set_config_item).raises(LXC::Error)
      @provider.send(:ipv4=,'192.168.1.102/24').should == false
    end
  end

  describe '#hwaddr' do
    it 'should return 00:de:ad:be:ef:00 from the getter' do
      @provider.container.stubs(:config_item).with('lxc.network.1.hwaddr').returns('00:de:ad:be:ef:00')
      @provider.send(:hwaddr).should == '00:de:ad:be:ef:00'
    end
    it 'should return true when the setter successfully changes the value' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.hwaddr')
      @provider.container.stubs(:set_config_item).with('lxc.network.1.hwaddr','01:de:ad:be:ef:01')
      @provider.container.stubs(:save_config)
      @provider.send(:hwaddr=,'01:de:ad:be:ef:01').should == true
    end
    it 'setter should return false if LXC::Error is raised' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.1.hwaddr')
      @provider.container.stubs(:set_config_item).raises(LXC::Error)
      @provider.send(:hwaddr=,'02:de:ad:be:ef:02').should == false
    end
  end
end

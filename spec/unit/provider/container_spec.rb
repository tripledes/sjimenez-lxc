require 'spec_helper'
require 'lxc'

describe Puppet::Type.type(:lxc).provider(:container) do

  before(:each) do
    @resource = Puppet::Type.type(:lxc).new(
      {
         :name     => 'lol_container',
         :state    => :running,
         :template => 'ubuntu',
         :provider => :container
      }
    )
    @provider = described_class.new(@resource)
    @provider.container = stub('LXC::Container')
  end

  describe '#symbolize_hash' do
    it 'should convert all keys to symbols' do
      @provider.send(:symbolize_hash, {'one' => 1, 'two' => 2}).should == {:one => 1, :two => 2}
    end
  end

  describe '#create' do
    it 'Will create the container and change its state to running' do
      @provider.container.stubs('create')
      @provider.container.stubs('set_config_item')
      @provider.container.stubs('save_config')
      @provider.container.stubs('start')
      @provider.container.stubs('wait')
      @provider.container.stubs('defined?').returns(false)
      @provider.container.stubs('state').returns(:stopped)
      expect(@provider.exists?).to be false
      expect(@provider.create).to be true
    end
  end

  describe '#destroy' do
    it 'will destroy the container' do
      @provider.container.stubs('destroy')
      @provider.container.stubs('stop')
      @provider.container.stubs('defined?').returns(true)
      @provider.container.stubs('state').returns(:running)
      @provider.container.stubs('wait')
      expect(@provider.stop).to be true
      expect(@provider.exists?).to be true
      expect(@provider.destroy).to be true
    end
  end

  describe '#start' do
    it 'will start the container if stopped' do
      @provider.container.stubs('state').returns(:stopped)
      @provider.container.stubs('start')
      @provider.container.stubs('wait').with(:running, 10)
      expect(@provider.start).to be true
    end
  end

  describe '#stop' do
    it 'will stop the container if running' do
      @provider.container.stubs('state').returns(:running)
      @provider.container.stubs('stop')
      @provider.container.stubs('wait').with(:stopped, 10)
      expect(@provider.stop).to be true
    end
  end

  describe '#freeze' do
    it 'will freeze the container' do
      @provider.container.stubs('state').returns(:running)
      @provider.container.stubs('freeze')
      @provider.container.stubs('wait').with(:frozen, 10)
      expect(@provider.freeze).to be true
    end
  end

  describe '#unfreeze' do
    it 'will unfreeze the container' do
      @provider.container.stubs('state').returns(:frozen)
      @provider.container.stubs('unfreeze')
      @provider.container.stubs('wait').with(:running, 10)
      expect(@provider.freeze).to be true
    end
  end

  describe '#status' do
    it 'will return :stopped when container is stopped' do
      @provider.container.stubs('state').returns(:stopped)
      expect(@provider.status).to be :stopped
    end
  end

  describe '#ipv4' do
    it 'will return 192.168.1.100/24 liblxc version < 1.1.0' do
      @provider.lxc_version = '1.0.6'
      file = Tempfile.new('foobar')
      file.write("lxc.network.name = eth0\nlxc.network.ipv4 = 192.168.1.100/24\nlxc.network.name = eth1\nlxc.network.type = veth\nlxc.network.ipv4 = 101.101.101.2/16\n")
      path = file.path
      file.close
      @provider.container.stubs(:config_file_name).returns(path)
      @provider.send(:ipv4).should == ['192.168.1.100/24']
      file.unlink
    end
    it 'will return 192.168.1.100/24 liblxc version >= 1.1.0' do
      @provider.lxc_version = '1.1.0'
      @provider.container.stubs(:config_item).with('lxc.network.0.ipv4').returns(['192.168.1.100/24'])
      @provider.send(:ipv4).should == '192.168.1.100/24'
    end
    it 'should return true when the setter successfully changes the value' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.0.ipv4')
      @provider.container.stubs(:set_config_item).with('lxc.network.0.ipv4','192.168.1.100/24')
      @provider.container.stubs(:save_config)
      @provider.send(:ipv4=,'192.168.1.100/24').should == true
    end
    it 'setter should return false if LXC::Error is raised' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.0.ipv4')
      @provider.container.stubs(:set_config_item).raises(LXC::Error)
      @provider.send(:ipv4=,'192.168.0.100/24').should == false
    end
  end

  describe '#ipv4_gateway' do
    it 'will return 192.168.1.254' do
      @provider.container.stubs(:config_item).with('lxc.network.0.ipv4_gateway').returns('192.168.1.254')
      @provider.send(:ipv4_gateway).should == '192.168.1.254'
    end
    it 'will return true when the setter successfully changes the value' do
      @provider.container.stubs(:clear_config_item).with('lxc.network.0.ipv4_gateway')
      @provider.container.stubs(:set_config_item).with('lxc.network.0.ipv4.gateway','192.168.1.253')
      @provider.container.stubs(:save_config)
      @provider.send(:ipv4_gateway=,'192.168.1.253').should == true
    end
  end
end

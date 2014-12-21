require 'spec_helper'
require 'lxc'

describe Puppet::Type.type(:lxc).provider(:container) do

  before(:each) do
    @resource = Puppet::Type.type(:lxc).new(
      {
         :name             => 'lol_container',
         :state            => :running,
         :template         => 'ubuntu',
         :provider         => :container,
         :template_options => ['--mirror', 'http://yourlocal.mirror/ubuntu'],
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

  describe '#autostart' do
    it 'will return true when container autostart is enabled' do
      @provider.container.stubs(:config_item).with('lxc.start.auto').returns('1')
      @provider.send(:autostart).should == :true
    end
    it 'will set autostart on/off' do
      @provider.container.stubs(:set_config_item).with('lxc.start.auto','1')
      @provider.container.stubs(:save_config)
      @provider.send(:autostart=,:true).should == true
    end
  end

  describe '#autostart_delay' do
    it 'will return the delay if present' do
      @provider.container.stubs(:config_item).with('lxc.start.delay').returns('10')
      @provider.send(:autostart_delay).should == '10'
    end
    it 'will set auto start delay value' do
      @provider.container.stubs(:set_config_item).with('lxc.start.delay','10')
      @provider.container.stubs(:save_config)
      @provider.send(:autostart_delay=,'10').should == true
    end
  end

  describe '#autostart_order' do
    it 'will return the order value for the container' do
      @provider.container.stubs(:config_item).with('lxc.start.order').returns('100')
      @provider.send(:autostart_order).should == '100'
    end
    it 'will the order for the container' do
      @provider.container.stubs(:set_config_item).with('lxc.start.order','100')
      @provider.container.stubs(:save_config)
      @provider.send(:autostart_order=,'100').should == true
    end
  end

  describe '#groups' do
    it 'will return an Array with all the groups' do
      @provider.container.stubs(:config_item).with('lxc.group').returns(['onboot','app01'])
      @provider.send(:groups).should == ['onboot','app01']
    end
    it 'will set the groups value' do
      @provider.container.stubs(:set_config_item).with('lxc.group',['onboot','app01'])
      @provider.container.stubs(:save_config)
      @provider.send(:groups=,['onboot','app01']).should == true
    end
  end

  describe '#ipv4' do
    it 'will fail as ipv4 is no longer supported' do
      @provider.container.stubs('ipv4')
      expect{@provider.ipv4}.to raise_error
    end
  end

  describe '#ipv4_gateway' do
    it 'will fail as ipv4_gateway is no longer supported' do
      @provider.container.stubs('ipv4_gateway')
      expect{@provider.ipv4_gateway}.to raise_error
    end
  end
end

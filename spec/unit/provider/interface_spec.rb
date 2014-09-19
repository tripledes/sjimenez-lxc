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
      @provider.container.stubs(:keys).returns(['name','hwaddr','ipv4','ipv6'])
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
end

require 'spec_helper'
require 'lxc'

describe Puppet::Type.type(:lxc_cgroups).provider(:cgroups), 'basic limit definition' do
  before(:each) do
    @resource = Puppet::Type.type(:lxc_cgroups).new(
      {
        :name  => 'memory.limit_in_bytes',
        :value => '2147483648',
      }
    )
    @provider = Puppet::Type.type(:lxc_cgroups).provider(:cgroups).new(@resource)
    @provider.container = stub('LXC::Container')
  end

  describe '#create' do
    it 'should return true when settings are applied successfully' do
      @provider.container.stubs(:set_cgroup_item)
      @provider.send(:create).should == true
    end
    it 'should return false when LXC::Error is raised' do
      @provider.container.stubs(:set_cgroup_item).raises(LXC::Error)
      @provider.send(:create).should == false
    end
  end

  describe '#exists?' do
    it 'should return false when defined value <> current value' do
      @provider.container.stubs(:cgroup_item).with('memory.limit_in_bytes').returns('1073741824')
      @provider.send(:exists?).should == false
    end
    it 'should return true when defined value == current value' do
      @provider.container.stubs(:cgroup_item).with('memory.limit_in_bytes').returns('2147483648')
      @provider.send(:exists?).should == true
    end
    it 'should return false when LXC::Error is raised' do
      @provider.container.stubs(:cgroup_item).raises(LXC::Error)
      @provider.send(:exists?).should == false
    end
  end

  describe '#destroy' do
    it 'should return true' do
      @provider.send(:destroy).should == true
    end
  end
end

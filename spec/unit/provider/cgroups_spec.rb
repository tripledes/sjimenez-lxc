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

  describe '#value' do
    it 'should return false when defined value <> current value' do
      @provider.container.stubs(:cgroup_item).with('memory.limit_in_bytes').returns('1073741824')
      @provider.send(:value).should == '1073741824'
    end
  end

  describe '#value=' do
    it 'should return true when setting new value' do
      @provider.container.stubs(:cgroup_item).with('memory.limit_in_bytes').returns('1073741824')
      @provider.container.stubs(:set_cgroup_item).with('memory.limit_in_bytes','2147483648')
      @provider.send(:value=, '2147483648').should == true
    end
  end
end

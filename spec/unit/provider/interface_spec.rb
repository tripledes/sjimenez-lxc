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
  end
end

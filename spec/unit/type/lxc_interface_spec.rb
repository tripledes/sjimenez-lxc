require 'spec_helper'

describe Puppet::Type.type(:lxc_interface), 'when validating attributes' do
  [:ensure,:link,:type,:ipv4,:vlan_id,:macvlan_mode,:hwaddr].each do |prop|
    it "should have a #{prop} property" do
      Puppet::Type.type(:lxc_interface).attrtype(prop).should == :property
    end
  end

  [:name, :container, :index].each do |param|
    it "should have a #{param} parameter" do
      Puppet::Type.type(:lxc_interface).attrtype(param).should == :param
    end
  end
end

describe Puppet::Type.type(:lxc_interface), 'when defining the resource' do

  it 'should fail if type has a non-supported value' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'blah', :index => 0)}.to raise_error
  end

  it 'should fail with an invalid IPv4 address' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'veth', :ipv4 => '256.0.280.0/16', :index => 0)}.to raise_error
  end

  it 'should not fail with a valid IPv4 address' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'veth', :ipv4 => '127.0.0.1/8', :index => 0)}.to_not raise_error
  end

  it 'should fail when using network type vlan and vlan id is missing' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'vlan', :index => 0)}.to raise_error
  end

  it 'should fail with a non-numeric VLAN ID' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'vlan', :vlan_id => 'AA', :index => 0)}.to raise_error
  end

  it 'should fail if network type is macvlan and macvlan_mode is missing' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'macvlan', :link => 'lxcbr0', :index => 0)}.to raise_error
  end

  it 'should fail if network type is macvlan and link is missing' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'macvlan', :macvlan_mode => 'private', :index => 0)}.to raise_error
  end

  it 'should fail if macvlan_mode is an invalid mode' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'macvlan', :link => 'lxcbr0', :macvlan_mode => 'blah', :index => 0)}.to raise_error
  end

  it 'should fail with an invalid hwaddr' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'veth', :hwaddr => 'AA:BB:CC:DD:EE:GG', :index => 0)}.to raise_error
  end

  it 'should fail if index is missing' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'veth')}.to raise_error
  end

  it 'should fail if index is not numeric' do
    expect{Puppet::Type.type(:lxc_interface).new(:name => 'eth0', :container => 'lol_container', :type => 'veth', :index => 'a')}.to raise_error
  end
end

require 'spec_helper'

describe Puppet::Type.type(:lxc), 'when validating attributes' do
  [:ensure, :state, :autostart, :autostart_delay, :autostart_order, :groups].each do |prop|
    it "should have a #{prop} property" do
      Puppet::Type.type(:lxc).attrtype(prop).should == :property
    end
  end

  [:ipv4, :ipv4_gateway].each do |noprop|
    it "should not have a #{noprop} property" do
      Puppet::Type.type(:lxc).attrtype(noprop).should_not == :property
    end
  end

  [:restart].each do |noparam|
    it "should not have a #{noparam} parameter" do
      Puppet::Type.type(:lxc).attrtype(noparam).should_not == :param
    end
  end

  [:name, :template, :template_options, :timeout, :storage_backend, :storage_options].each do |param|
    it "should have a #{param} parameter" do
      Puppet::Type.type(:lxc).attrtype(param).should == :param
    end
  end
end

describe Puppet::Type.type(:lxc), 'when validating attribute values' do
  before do
    @provider_class = described_class.provide(:container) { mk_resource_methods }
    described_class.stubs(:defaultprovider).returns @provider_class
  end

  it 'should support :running as value for :state' do
    Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running)
  end

  it 'should support :stopped as value for :state' do
    Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :stopped)
  end

  it 'should support :frozen as value for :state' do
    Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :frozen)
  end

  it 'should raise error for :nonsense as value for :storage_backend' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :nonsense)
    }.to raise_error
  end

  [:dir, :lvm, :btrfs, :loop, :best].each do |backend|
    it "should support #{backend} as value for :storage_backend" do
      expect {
        Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => backend)
      }.to_not raise_error
    end
  end

  it 'should raise error for non-Hash type as value for :storage_options' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :lvm, :storage_options => [0,1])
    }.to raise_error
  end

  it 'should raise error for invalid key on :storage_options Hash' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :lvm, :storage_options => {'invalid_key' => 1 })
    }.to raise_error
  end

  it 'should raise error for non-Array as value for :template_options' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :template_options => :nonsense)
    }.to raise_error
  end

  it 'should support dir as valid key for :storage_options Hash' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :dir, :storage_options => {'dir' => '/tmp' })
    }.to_not raise_error
  end

  it 'should raise an error if storage_options holds dir and any other option' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_options => {'dir' => '/tmp', 'anyother' => 1})
    }.to raise_error
  end

  it 'should raise an error with :lvm and storage_options has dir' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :lvm, :storage_options => {'dir' => '/tmp'})
    }.to raise_error
  end

  it 'should support vgname, lvname, thinpool, fstype and fssize as valid keys for :storage_options Hash' do
    storage_options = {
      'vgname' => 'lxc',
      'lvname' => 'lol_container01',
      'thinpool' => 'oversized01',
      'fstype' => 'xfs',
      'fssize' => '2048'
    }
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :lvm, :storage_options => storage_options)
    }.to_not raise_error
  end

  it 'should fail when autostart is not boolean' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :autostart => 'blahblah')
    }.to raise_error
  end

  it 'should fail when autostart_delay is not numeric' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :autostart_delay => 'blehbleh')
    }.to raise_error
  end

  it 'should fail when autostart_order is not numeric' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :autostart_order => 'blehbleh')
    }.to raise_error
  end

  it 'should fail when groups is not Array' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :groups => 'blehbleh')
    }.to raise_error
  end
end

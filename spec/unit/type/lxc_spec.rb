require 'spec_helper'

describe Puppet::Type.type(:lxc), 'when validating attributes' do
  [:ensure, :state, :ipv4, :ipv4_gateway].each do |prop|
    it "should have a #{prop} property" do
      Puppet::Type.type(:lxc).attrtype(prop).should == :property
    end
  end

  [:name, :template, :template_options, :timeout, :storage_backend, :storage_options, :restart].each do |param|
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

  it 'should fail when using an invalid ipv4 address' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :ipv4 => '340.40.30.256/24')
    }.to raise_error
  end

  it 'should fail when using an invalid ipv4 address as gateway' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :ipv4_gateway => '340.40.30.256/24')
    }.to raise_error
  end

  it 'should fail when restart is not boolean' do
    expect {
      Puppet::Type.type(:lxc).new(:name => 'lol_container', :restart => 'blahblah')
    }.to raise_error
  end

end

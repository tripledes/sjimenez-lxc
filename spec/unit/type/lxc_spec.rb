require 'spec_helper'

describe Puppet::Type.type(:lxc), 'when validating attributes' do
  [:ensure, :state].each do |prop|
    it "should have a #{prop} property" do
      Puppet::Type.type(:lxc).attrtype(prop).should == :property
    end
  end

  [:name, :template, :timeout, :storage_backend, :storage_options].each do |param|
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
    expect { Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :nonsense) }.to raise_error
  end

  [:dir, :lvm, :btrfs, :loop, :best].each do |backend|
    it "should support #{backend} as value for :storage_backend" do
      expect { Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => backend) }.to_not raise_error
    end
  end

  it 'should raise error for non-Hash type as value for :storage_options' do
    expect { Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :lvm, :storage_options => [0,1]) }.to raise_error
  end

  it 'should raise error for invalid key on :storage_options Hash' do
    expect { Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :lvm, :storage_options => {'invalid_key' => 1 }) }.to raise_error
  end

  it 'should support dir as valid key for :storage_options Hash' do
    expect { Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :lvm, :storage_options => {'dir' => '/tmp' }) }.to_not raise_error
  end

  it 'should support vgname, lvname, thinpool, fstype and fssize as valid keys for :storage_options Hash' do
    storage_options = {
      'vgname' => 'lxc',
      'lvname' => 'lol_container01',
      'thinpool' => 'oversized01',
      'fstype' => 'xfs',
      'fssize' => '2048'
    }
    expect { Puppet::Type.type(:lxc).new(:name => 'lol_container', :state => :running, :storage_backend => :lvm, :storage_options => storage_options) }.to_not raise_error
  end
end


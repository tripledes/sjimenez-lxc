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

end


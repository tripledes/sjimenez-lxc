require 'spec_helper'

describe Puppet::Type.type(:lxc_cgroups), 'when validating attributes' do
  [:value].each do |prop|
    it "should have a #{prop} property" do
      Puppet::Type.type(:lxc_cgroups).attrtype(prop).should == :property
    end
  end

  [:name].each do |param|
    it "should have a #{param} parameter" do
      Puppet::Type.type(:lxc_cgroups).attrtype(param).should == :param
    end
  end
end

describe Puppet::Type.type(:lxc_cgroups), 'when defining the resource' do
  it 'should fail if name has a wrong controller' do
    expect {
      Puppet::Type.type(:lxc_cgroups).new(
        :name => 'wrong_controller.limit_in_bytes', :value => '2G'
      )
    }.to raise_error
  end
  it 'should fail if value is not a String' do
    expect {
      Puppet::Type.type(:lxc_cgroups).new(
        :name => 'memory.limit_in_bytes', :value => 2048
      )
    }.to raise_error
  end
end

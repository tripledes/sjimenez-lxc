require 'spec_helper'
describe 'lxc' do

  context 'with defaults for all parameters' do
    it { should contain_class('lxc') }
  end
end

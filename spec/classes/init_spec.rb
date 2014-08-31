require 'spec_helper'
describe 'lxc' do

  context 'with defaults for all parameters' do

    let(:facts) { {:operatingsystem => 'Ubuntu', :operatingsystemrelease => '14.04'} }

    it { should contain_class('lxc') }

    it { should contain_package('build-essential','ruby-dev','lxc-dev').with_ensure('latest') }

    it { should contain_package('lxc-bindings').with(
      {
        :name     => 'ruby-lxc',
        :provider => :gem,
      })
    }
  end
end

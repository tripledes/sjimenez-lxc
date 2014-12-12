require 'spec_helper'
describe 'lxc',:type => :class do

  shared_examples 'common resources' do
    it { should contain_class('lxc') }

    it { should contain_package('build-essential','ruby-dev','lxc-dev').with_ensure('latest') }

    it { should contain_package('lxc-bindings').with(
      {
        :name     => 'ruby-lxc',
        :provider => :gem,
      })
    }
  end

  context 'Ubuntu Trusty' do
    let(:facts) do
      {
        :osfamily        => 'Debian',
        :operatingsystem => 'Ubuntu',
        :lsbdistcodename => 'trusty',
        :lsbdistid       => 'Ubuntu',
      }
    end

    it_behaves_like 'common resources'
  end

  context 'Ubuntu Precise' do
    let(:facts) do
      {
        :osfamily        => 'Debian',
        :operatingsystem => 'Ubuntu',
        :lsbdistcodename => 'precise',
        :lsbdistid       => 'Ubuntu',
      }
    end

    it_behaves_like 'common resources'

    it do
      should contain_apt__ppa('lxc')
    end
  end
end

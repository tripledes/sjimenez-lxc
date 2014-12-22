require 'spec_helper'

describe 'lxc::networking::containers', :type => :class do
  context 'with default parameters' do
    let(:facts) do
      {
        :operatingsystem => 'Ubuntu',
        :lsbdistcodename => 'trusty',
      }
    end

    it do
      expect{ should }.to raise_error
    end
  end

  context 'with wrong networking_container_ensure' do
    let(:facts) do
      {
        :operatingsystem => 'Ubuntu',
        :lsbdistcodename => 'trusty',
      }
    end

    let(:params) do
      {
        :networking_container_ensure => 'blahblah',
        :networking_device_link      => 'lxcbr0',
        :networking_type             => 'macvlan',
      }
    end

    it do
      expect{ should }.to raise_error(Puppet::Error,/must be either present or absent/)
    end
  end


  context 'with all required parameters' do
    let(:facts) do
      {
        :operatingsystem => 'Ubuntu',
        :lsbdistcodename => 'trusty',
      }
    end

    let(:params) do
      {
        :networking_device_link => 'lxcbr0',
        :networking_type        => 'veth',
      }
    end

    it do
      should contain_file('/etc/lxc/default.conf').with({
        :content => /lxc\.network\.type = veth\nlxc\.network\.link = lxcbr0/
      })
    end
  end
end

require 'spec_helper'
describe 'lxc',:type => :class do

  shared_examples 'common resources' do

    it do
      should contain_class('lxc')
    end

    it do
      should contain_class('lxc::install')
    end

    it do
      should contain_class('lxc::service')
    end

    it do
      should contain_class('lxc::networking::containers')
    end

    it do
      should contain_class('lxc::networking::nat')
    end

    it do
      should contain_package('build-essential','ruby-dev','lxc-dev').with_ensure('latest')
    end

    it do
      should contain_package('lxc-bindings').with({
        :name     => 'ruby-lxc',
        :provider => :gem,
      })
    end

    it do
      should contain_file('/etc/lxc/default.conf').with({
        :content => /lxc\.network\.type = macvlan\nlxc\.network\.link = eth0.*lxc\.network\.macvlan\.mode = bridge\n/m
      })
    end

    it do
      should contain_file('/etc/default/lxc-net').with({
        :content => /USE_LXC_BRIDGE="true"\nLXC_BRIDGE="lxcbr1".*LXC_DHCP_MAX="128".*LXC_DOMAIN="local\.lxc"/m,
      })
    end

    it do
      should contain_file('/etc/lxc/dnsmasq.conf').with({
        :content => /dhcp-host=mail1,10\.0\.3\.100/,
      })
    end

    it do
      should contain_service('lxc-net').with_ensure('running')
    end

    it do
      should contain_service('lxc').with_ensure('running')
    end

    it do
      should contain_augeas('system-wide-dnsmasq')
    end
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

    let(:params) do
      {
        :lxc_networking_device_link        => 'eth0',
        :lxc_networking_type               => 'macvlan',
        :lxc_networking_extra_options      => {'lxc.network.macvlan.mode' => 'bridge'},
        :lxc_networking_nat_bridge         => 'lxcbr1',
        :lxc_networking_nat_max_hosts      => '128',
        :lxc_networking_nat_dns_domain     => 'local.lxc',
        :lxc_networking_nat_dhcp_conf      => '/etc/lxc/dnsmasq.conf',
        :lxc_networking_nat_dhcp_options   => {'dhcp-host' => 'mail1,10.0.3.100'},
        :lxc_networking_nat_update_dnsmasq => true,
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

    let(:params) do
      {
        :lxc_networking_device_link        => 'eth0',
        :lxc_networking_type               => 'macvlan',
        :lxc_networking_extra_options      => {'lxc.network.macvlan.mode' => 'bridge'},
        :lxc_networking_nat_bridge         => 'lxcbr1',
        :lxc_networking_nat_max_hosts      => '128',
        :lxc_networking_nat_dns_domain     => 'local.lxc',
        :lxc_networking_nat_dhcp_conf      => '/etc/lxc/dnsmasq.conf',
        :lxc_networking_nat_dhcp_options   => {'dhcp-host' => 'mail1,10.0.3.100'},
        :lxc_networking_nat_update_dnsmasq => true,
      }
    end

    it_behaves_like 'common resources'

    it do
      should contain_package('rubygems').with_ensure('latest')
    end

    it do
      should contain_apt__ppa('lxc')
    end
  end
end

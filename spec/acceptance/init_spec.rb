require 'spec_helper_acceptance'

describe 'lxc class' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        package { 'cgroup-bin':
          ensure => latest,
        }

        class { 'lxc':
          lxc_networking_nat_address        => '10.0.4.1',
          lxc_networking_nat_mask           => '255.255.255.0',
          lxc_networking_nat_network        => '10.0.4.0/24',
          lxc_networking_nat_dhcp_range     => '10.0.4.2,10.0.4.254',
          lxc_networking_nat_dns_domain     => 'local.lxc',
          lxc_networking_nat_dhcp_conf      => '/etc/lxc/dnsmasq.conf',
          lxc_networking_nat_dhcp_options   => {'dhcp-host' => 'mail1,10.0.4.100'},
        }

        lxc { 'ubuntu_test':
          ensure           => present,
          state            => running,
          autostart        => true,
          template         => 'ubuntu',
          template_options => ['--mirror', 'http://10.0.2.2:3142/ubuntu'],
        }

        lxc_interface { 'public':
          container    => 'ubuntu_test',
          index        => 0,
          device_name  => 'eth0',
          ipv4         => '10.0.3.2/24',
          restart      => true,
        }

        lxc_cgroups { 'memory.limit_in_bytes':
          container => 'ubuntu_test',
          value     => '1073741824',
        }

        Class['lxc'] -> Lxc<||> -> Lxc_interface<||> -> Lxc_cgroups<||>
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_changes => true).exit_code).to be_zero
    end
  end

  describe package('lxc') do
    it do
      should be_installed
    end
  end

  describe lxc('ubuntu_test') do
    it { should exist }
    it { should be_running }
  end

  describe command('lxc-ls --fancy | grep "10.0.3.2"') do
    its(:exit_status) do
      should eq 0
    end
  end

  describe command('lxc-ls --fancy | grep "ubuntu_test" | grep "YES"') do
    its(:exit_status) do
      should eq 0
    end
  end

  describe command('grep veth /etc/lxc/default.conf') do
    its(:exit_status) do
      should eq 0
    end
  end

  describe command('grep mail1 /etc/lxc/dnsmasq.conf') do
    its(:exit_status) do
      should eq 0
    end
  end

  describe command("grep 'local\.lxc' /etc/default/lxc-net") do
    its(:exit_status) do
      should eq 0
    end
  end

  describe service('lxc') do
    it do
      should be_enabled
    end
  end

  describe service('lxc-net') do
    it do
      should be_enabled
    end
  end

  describe interface('lxcbr0') do
    it do
      should have_ipv4_address('10.0.4.1')
    end
  end

  describe cgroup('lxc/ubuntu_test') do
    its('memory.limit_in_bytes') { should eq 1073741824 }
  end
end

require 'spec_helper_acceptance'

describe 'lxc class' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include 'lxc'

        lxc { 'ubuntu_test':
          ensure           => present,
          state            => running,
          template         => 'ubuntu',
          template_options => ['--mirror', 'http://de.archive.ubuntu.com/ubuntu'],
        }

        lxc_interface { 'public':
          container   => 'ubuntu_test',
          index       => 0,
          device_name => 'eth0',
          ipv4        => '10.0.3.2/24',
          restart     => true,
        }
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
end

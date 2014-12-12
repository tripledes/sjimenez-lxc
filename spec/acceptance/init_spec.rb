require 'spec_helper_acceptance'

describe 'lxc class' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include 'lxc'

        lxc { 'ubuntu_test':
          ensure   => present,
          state    => running,
          template => 'ubuntu',
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
end

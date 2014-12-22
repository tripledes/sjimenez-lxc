require 'beaker-rspec'

hosts.each do |host|
  on host, "mkdir -p #{host['distmoduledir']}"
end

SUPPORTED_PLATFORMS = ['trusty','precise']

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module
    puppet_module_install(:source => proj_root, :module_name => 'lxc')
    hosts.each do |host|

      on host, shell('touch /etc/puppet/hiera.yaml')
      # Using this approach with Ubuntu Precise makes the test to fail
      # as Puppet exits with 6 although the catalog seems to be applied properly
      if options[:HOSTS].key?:'ubuntu-server-12042-x64'
        on host, shell('apt-get purge -y ruby ruby-dev')
        on host, shell('apt-get install -y ruby1.9.1-dev augeas-lenses debconf-utils libaugeas-ruby1.9.1 libaugeas0 virt-what')
        on host, shell('gem1.9.1 install puppet --bindir /usr/bin --no-rdoc --no-ri')
      end

      on host, puppet('module','install','puppetlabs-apt','--version','1.7.0'), { :acceptable_exit_codes => [0,1] }
    end
  end
end


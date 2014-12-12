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
      on host, shell('wget -O /tmp/puppetlabs.deb http://apt.puppetlabs.com/puppetlabs-release-stable.deb')
      on host, shell('dpkg -i /tmp/puppetlabs.deb')
      on host, shell('apt-get update')
      install_package master, 'puppet'
      on host, puppet('module','install','puppetlabs-apt','--version','1.7.0'), { :acceptable_exit_codes => [0,1] }
    end
  end
end


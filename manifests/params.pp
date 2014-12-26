# == Class: lxc::params
#
# This class defines defaults based on $::operatingsystem.
#
# === Authors
#
# Sergio Jimenez <tripledes@gmail.com>
#
# === Copyright
#
# Copyright 2014 Sergio Jimenez, unless otherwise noted.
#
class lxc::params {
  case $::operatingsystem {
    'Ubuntu': {
      case $::lsbdistcodename {
        'trusty': {
          $lxc_ruby_bindings_gem_deps = [
            'build-essential', 'ruby-dev', 'lxc-dev', 'libcgmanager0'
          ]
        }
        'precise': {
          contain 'lxc::sources::precise'
          $lxc_ruby_bindings_gem_deps = [
            'build-essential', 'ruby-dev', 'lxc-dev', 'libcgmanager0',
            'rubygems'
          ]
        }
        default: {
          fail("Only Ubuntu ${::lsbdistcodename} is not supported by ${module_name}.")
        }
      }
    }
    default: {
      fail("${::operatingsystem} is not supported by ${module_name} module.")
    }
  }

  $lxc_ruby_bindings_provider        = gem
  $lxc_ruby_bindings_package         = 'ruby-lxc'
  $lxc_ruby_bindings_version         = '1.2.0'
  $lxc_lxc_package                   = 'lxc'
  $lxc_lxc_version                   = latest
  $lxc_lxc_service                   = 'lxc'
  $lxc_lxc_service_ensure            = running
  $lxc_lxc_service_enabled           = true
  $lxc_networking_device_link        = 'lxcbr0'
  $lxc_networking_type               = 'veth'
  $lxc_networking_flags              = 'up'
  $lxc_networking_hwaddr             = '00:16:3e:xx:xx:xx'
  $lxc_networking_nat_enable         = true
  $lxc_networking_nat_bridge         = 'lxcbr0'
  $lxc_networking_nat_address        = '10.0.3.1'
  $lxc_networking_nat_mask           = '255.255.255.0'
  $lxc_networking_nat_network        = '10.0.3.0/24'
  $lxc_networking_nat_dhcp_range     = '10.0.3.2,10.0.3.254'
  $lxc_networking_nat_max_hosts      = '253'
  $lxc_networking_nat_update_dnsmasq = false
  $lxc_networking_nat_dnsmasq_conf   = '/etc/dnsmasq.d/lxc'
  $network_default_conf              = '/etc/lxc/default.conf'
  $network_nat_conf                  = '/etc/default/lxc-net'
  $network_nat_service               = 'lxc-net'
}


# == Class: lxc::networking::nat
#
# This class manages the host networking settings to create a Nat'ed bridge.
#
# === Authors
#
# Sergio Jimenez <tripledes@gmail.com>
#
# === Copyright
#
# Copyright 2014 Sergio Jimenez, unless otherwise noted.
#
class lxc::networking::nat inherits lxc::params {

  private()

  case $lxc::lxc_networking_nat_enable {
    true: {
      $nat_ensure = present
      $srv_nat_ensure = running
      $srv_nat_enable = true
    }
    false: {
      $nat_ensure = absent
      $srv_nat_ensure = stopped
      $srv_nat_enable = false
    }
    default: {
      fail('lxc_networking_nat_enable must be either true or false')
    }
  }

  $local_lxc_networking_nat_dns_domain = $lxc::lxc_networking_nat_dns_domain

  file { $lxc::params::network_nat_conf:
    ensure  => $nat_ensure,
    content => template("${module_name}/config/lxc-net.erb"),
    notify  => Service[$lxc::params::network_nat_service],
  }

  if $lxc::lxc_networking_nat_dhcp_conf {
    $local_lxc_networking_nat_dhcp_options = $lxc::lxc_networking_nat_dhcp_options

    file { $lxc::lxc_networking_nat_dhcp_conf:
      ensure  => $nat_ensure,
      content => template("${module_name}/config/dnsmasq.conf.erb"),
      notify  => Service[$lxc::params::network_nat_service],
    }
  }

  if $lxc::lxc_networking_nat_update_dnsmasq {
    augeas { 'system-wide-dnsmasq':
      context => "/files${lxc::lxc_networking_nat_dnsmasq_conf}",
      changes => "set except-interface ${lxc::lxc_networking_nat_bridge}",
    }
  }

  service { $lxc::params::network_nat_service:
    ensure => $srv_nat_ensure,
    enable => $srv_nat_enable,
  }
}


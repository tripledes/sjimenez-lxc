# == Class: lxc::networking::containers
#
# This class manages the default networking settings for containers.
#
# === Parameters
#
# [*networking_container_ensure*]
#   Whether configuration is present or absent. Default is present.
#
# [*networking_device_link*]
#   Host device to be used as link, i.e. lxcbr0.
#
# [*networking_type*]
#   The networking type containers will use by default, i.e. veth.
#
# [*networking_flags*]
#   Networking flags, up activates the interface.
#
# [*networking_hwaddr*]
#   The parameter controls a fixed part of the MAC address, to randomly generate
#   containers new MACs.
#
# === Examples
#
#  class { 'lxc::networking::containers':
#    networking_device_link => 'eth0',
#    networking_type        => 'macvlan',
#  }
#
# === Authors
#
# Sergio Jimenez <tripledes@gmail.com>
#
# === Copyright
#
# Copyright 2014 Sergio Jimenez, unless otherwise noted.
#
class lxc::networking::containers (
  $networking_container_ensure = present,
  $networking_device_link      = undef,
  $networking_type             = undef,
  $networking_flags            = 'up',
  $networking_hwaddr           = '00:16:3e:xx:xx:xx',
) inherits lxc::params {
  if empty($networking_device_link) and empty($networking_type) {
    fail('networking_device_link and networking_type are required')
  }

  validate_re($networking_container_ensure,['^absent$','^present$'],
  'networking_container_ensure, must be either present or absent')

  file { $lxc::params::network_default_conf:
    ensure  => $networking_container_ensure,
    content => template("${module_name}/config/default.conf.erb"),
  }
}

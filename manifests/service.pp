# == Class: lxc::service
#
# This class manages LXC service state
#
# === Examples
#
#  include lxc::service
#
# === Authors
#
# Sergio Jimenez <tripledes@gmail.com>
#
# === Copyright
#
# Copyright 2014 Sergio Jimenez, unless otherwise noted.
#
class lxc::service {
  if $caller_module_name != $module_name {
    fail('Lxc::service is not a public class')
  }

  service { $lxc::lxc_lxc_service:
    ensure => $lxc::lxc_lxc_service_ensure,
    enable => $lxc::lxc_lxc_service_enabled,
  }
}


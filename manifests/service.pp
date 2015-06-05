# == Class: lxc::service
#
# This class manages LXC service state.
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

  assert_private()

  service { $lxc::lxc_lxc_service:
    ensure => $lxc::lxc_lxc_service_ensure,
    enable => $lxc::lxc_lxc_service_enabled,
  }
}


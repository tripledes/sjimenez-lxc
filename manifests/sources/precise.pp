# == Class: lxc::sources::precise
#
# This class manages the LXC PPA for Ubuntu 12.04.
#
# === Authors
#
# Sergio Jimenez <tripledes@gmail.com>
#
# === Copyright
#
# Copyright 2014 Sergio Jimenez, unless otherwise noted.
#
class lxc::sources::precise {

  private()

  contain 'apt'

  apt::ppa { 'lxc':
    ensure  => present,
    name    => 'ppa:ubuntu-lxc/stable',
    release => 'precise',
    tag     => 'lxc',
  }

  Apt::Ppa <| tag == 'lxc' |> -> Package <| tag == 'lxc_packages' |>
}

# == Class: lxc::install
#
# This class manages the installation of lxc tools, bindings and dependencies.
#
# === Authors
#
# Sergio Jimenez <tripledes@gmail.com>
#
# === Copyright
#
# Copyright 2014 Sergio Jimenez, unless otherwise noted.
#
class lxc::install inherits lxc::params {

  assert_private()

  $lxc_ruby_bindings_deps = $lxc::lxc_ruby_bindings_provider ? {
    gem     => $lxc::lxc_ruby_bindings_gem_deps,
    default => ['']
  }

  package { $lxc::lxc_lxc_package:
    ensure => $lxc::lxc_lxc_version,
    tag    => 'lxc_packages',
    notify => Class['lxc::service'],
  }

  package { $lxc_ruby_bindings_deps:
    ensure => latest,
    tag    => 'lxc_packages',
  }

  package { 'lxc-bindings':
    ensure   => $lxc::lxc_ruby_bindings_version,
    name     => $lxc::lxc_ruby_bindings_package,
    provider => $lxc::lxc_ruby_bindings_provider,
    require  => Package[$lxc::lxc_lxc_package, $lxc_ruby_bindings_deps],
  }
}

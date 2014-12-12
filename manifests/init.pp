# == Class: lxc
#
# This class installs the requirements for managing LXC containers.
#
# === Parameters
#
# [*lxc_ruby_bindings_provider*]
#   Provider used to install LXC ruby bindings. Defaults to gem.
#
# [*lxc_ruby_bindings_package*]
#   Name for the LXC ruby bindings. Defaults to ruby-lxc.
#
# [*lxc_ruby_bindings_version*]
#   Version for LXC ruby bindings. Defaults to 1.2.0.
#
# [*lxc_lxc_package*]
#   Package for installing lxc tools and libraries. Defaults to lxc.
#
# [*lxc_lxc_version*]
#   Version for *lxc_lxc_package*. Defaults to 1.0.5-0ubuntu0.1
#
# [*lxc_lxc_service*]
#   Name for lxc service. Defaults to lxc.
#
# [*lxc_lxc_service_ensure*]
#   Defines state for LXC service. Defaults to running.
#
# [*lxc_lxc_service_enabled*]
#   Enables/disables LXC service on boot time. Defaults to true.
#
# === Examples
#
#  include lxc
#
# === Authors
#
# Sergio Jimenez <tripledes@gmail.com>
#
# === Copyright
#
# Copyright 2014 Sergio Jimenez, unless otherwise noted.
#
class lxc (
  $lxc_ruby_bindings_provider = $lxc::params::lxc_ruby_bindings_provider,
  $lxc_ruby_bindings_package  = $lxc::params::lxc_ruby_bindings_package,
  $lxc_ruby_bindings_version  = $lxc::params::lxc_ruby_bindings_version,
  $lxc_lxc_package            = $lxc::params::lxc_lxc_package,
  $lxc_lxc_version            = $lxc::params::lxc_lxc_version,
  $lxc_lxc_service            = $lxc::params::lxc_lxc_service,
  $lxc_lxc_service_ensure     = $lxc::params::lxc_lxc_service_ensure,
  $lxc_lxc_service_enabled    = $lxc::params::lxc_lxc_service_enabled
) inherits lxc::params {

  $lxc_ruby_bindings_deps = $lxc_ruby_bindings_provider ? {
    gem     => $lxc::params::lxc_ruby_bindings_gem_deps,
    default => ['']
  }

  package { $lxc_lxc_package:
    ensure => $lxc_lxc_version,
    tag    => 'lxc_packages',
  }

  package { $lxc_ruby_bindings_deps:
    ensure => latest,
    tag    => 'lxc_packages',
  }

  package { 'lxc-bindings':
    ensure   => $lxc_ruby_bindings_version,
    name     => $lxc_ruby_bindings_package,
    provider => $lxc_ruby_bindings_provider,
    require  => Package[$lxc_lxc_package, $lxc_ruby_bindings_deps],
  }

  service { $lxc_lxc_service:
    ensure => $lxc_lxc_service_ensure,
    enable => $lxc_lxc_service_enabled,
  }
}

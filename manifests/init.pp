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
#   Version for $lxc_lxc_package. Defaults to latest.
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
# [*lxc_networking_container_ensure*]
#   Whether configuration is present or absent. Default is present.
#
# [*lxc_networking_device_link*]
#   Host device to be used as link, i.e. lxcbr0.
#
# [*lxc_networking_type*]
#   The networking type containers will use by default, i.e. veth.
#
# [*lxc_networking_flags*]
#   Networking flags, up activates the interface. Defaults to 'up'.
#
# [*lxc_networking_hwaddr*]
#   The parameter controls a fixed part of the MAC address, to randomly generate
#   containers new MACs. Defaults to '00:16:3e:xx:xx:xx'.
#
# [*lxc_networking_nat_bridge*]
#   Bridge to be used as link device for containers. Default is 'lxcbr0'.
#
# [*lxc_networking_nat_address*]
#   Address for the bridge. Default '10.0.3.1'.
#
# [*lxc_networking_nat_mask*]
#   Mask address for the bridge. Default '255.255.255.0'.
#
# [*lxc_networking_nat_network*]
#   Network address for the bridge. Default '10.0.3.0/24'.
#
# [*lxc_networking_nat_dhcp_range*]
#   DHCP range, comman-separated. Default '10.0.3.2,10.0.3.254'.
#
# [*lxc_networking_nat_max_hosts*]
#   Maximum number of hosts to be assigned by the DHCP server. Default 253.
#
# [*lxc_networking_nat_dns_domain*]
#   DNS domain to be assigned by the DHCP server. Default undef.
#
# [*lxc_networking_nat_dhcp_conf*]
#   Configuration file to be used for LXC's DHCP server. Default undef.
#
# [*lxc_networking_nat_dhcp_options*]
#   A hash with DHCP specific options, it will be used to create
#   the file pointed by $networking_nat_dhcp_conf. The end result
#   will be in the format key=value. Default undef.
#
# [*lxc_networking_nat_update_dnsmasq*]
#   Whether to update system-wide dnsmasq instance to avoid it binding
#   on $lxc_networking_nat_bridge. Default false.
#
# [*lxc_networking_nat_dnsmasq_conf*]
#   System-wide dnsmasq configuration file, where except-interface setting
#   will be modified with $lxc_networking_nat_bridge value. Default
#   /etc/dnsmasq.d/lxc.
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
  $lxc_ruby_bindings_provider        = $lxc::params::lxc_ruby_bindings_provider,
  $lxc_ruby_bindings_package         = $lxc::params::lxc_ruby_bindings_package,
  $lxc_ruby_bindings_version         = $lxc::params::lxc_ruby_bindings_version,
  $lxc_lxc_package                   = $lxc::params::lxc_lxc_package,
  $lxc_lxc_version                   = $lxc::params::lxc_lxc_version,
  $lxc_lxc_service                   = $lxc::params::lxc_lxc_service,
  $lxc_lxc_service_ensure            = $lxc::params::lxc_lxc_service_ensure,
  $lxc_lxc_service_enabled           = $lxc::params::lxc_lxc_service_enabled,
  $lxc_cgmanager_service             = $lxc::params::lxc_cgmanager_service,
  $lxc_cgmanager_service_ensure      = $lxc::params::lxc_cgmanager_service_ensure,
  $lxc_cgmanager_service_enabled     = $lxc::params::lxc_cgmanager_service_enabled,
  $lxc_networking_device_link        = $lxc::params::lxc_networking_device_link,
  $lxc_networking_type               = $lxc::params::lxc_networking_type,
  $lxc_networking_flags              = $lxc::params::lxc_networking_flags,
  $lxc_networking_hwaddr             = $lxc::params::lxc_networking_hwaddr,
  $lxc_networking_extra_options      = undef,
  $lxc_networking_nat_enable         = $lxc::params::lxc_networking_nat_enable,
  $lxc_networking_nat_bridge         = $lxc::params::lxc_networking_nat_bridge,
  $lxc_networking_nat_address        = $lxc::params::lxc_networking_nat_address,
  $lxc_networking_nat_mask           = $lxc::params::lxc_networking_nat_mask,
  $lxc_networking_nat_network        = $lxc::params::lxc_networking_nat_network,
  $lxc_networking_nat_dhcp_range     = $lxc::params::lxc_networking_nat_dhcp_range,
  $lxc_networking_nat_max_hosts      = $lxc::params::lxc_networking_nat_max_hosts,
  $lxc_networking_nat_dns_domain     = undef,
  $lxc_networking_nat_dhcp_conf      = undef,
  $lxc_networking_nat_dhcp_options   = undef,
  $lxc_networking_nat_update_dnsmasq = $lxc::params::lxc_networking_nat_update_dnsmasq,
  $lxc_networking_nat_dnsmasq_conf   = $lxc::params::lxc_networking_nat_dnsmasq_conf
) inherits lxc::params {

  contain 'lxc::install'
  contain 'lxc::service'
  contain 'lxc::networking::containers'
  contain 'lxc::networking::nat'

  Class['lxc::install'] ->
  Class['lxc::service'] ->
  Class['lxc::networking::containers'] ->
  Class['lxc::networking::nat']
}

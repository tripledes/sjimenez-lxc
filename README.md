# lxc

[![Build Status](https://travis-ci.org/tripledes/sjimenez-lxc.png?branch=master)](https://travis-ci.org/tripledes/sjimenez-lxc)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Reference](#reference)
4. [Usage](#usage)
5. [NOTES](#notes)
6. [TODO](#todo)
7. [Limitations - OS compatibility, etc.](#limitations)
8. [Contributions](#contributions)

## Overview

Manages the state of LXC based containers on a Ubuntu host.

## Module Description

This module installs LXC tools, LXC Ruby bindings, manages LXC service and configures
LXC networking settings. The lxc module adds the following resources to Puppet:

 * lxc
 * lxc_interface

For more information about LXC visit: [linuxcontainers.org](https://linuxcontainers.org/).


## Reference

### Classes

#### Public Classes

* `lxc`: Main class, provides logic and public interface with the following parameters:

 * lxc_ruby_bindings_provider
  Provider used to install LXC ruby bindings. Defaults to gem.

 * lxc_ruby_bindings_package
  Name for the LXC ruby bindings. Defaults to ruby-lxc.

 * lxc_ruby_bindings_version
  Version for LXC ruby bindings. Defaults to 1.2.0.

 * lxc_lxc_package
  Package for installing lxc tools and libraries. Defaults to lxc.

 * lxc_lxc_version
  Version for $lxc_lxc_package. Defaults to latest.

 * lxc_lxc_service
  Name for lxc service. Defaults to lxc.

 * lxc_lxc_service_ensure
  Defines state for LXC service. Defaults to running.

 * lxc_lxc_service_enabled
  Enables/disables LXC service on boot time. Defaults to true.

 * lxc_networking_container_ensure
  Whether configuration is present or absent. Default is present.

 * lxc_networking_device_link
  Host device to be used as link, i.e. lxcbr0.

 * lxc_networking_type
  The networking type containers will use by default, i.e. veth.

 * lxc_networking_flags
  Networking flags, up activates the interface. Defaults to 'up'.

 * lxc_networking_hwaddr
  The parameter controls a fixed part of the MAC address, to randomly generate
  containers new MACs. Defaults to '00:16:3e:xx:xx:xx'.

 * lxc_networking_nat_bridge
  Bridge to be used as link device for containers. Default is 'lxcbr0'.

 * lxc_networking_nat_address
  Address for the bridge. Default '10.0.3.1'.

 * lxc_networking_nat_mask
  Mask address for the bridge. Default '255.255.255.0'.

 * lxc_networking_nat_network
  Network address for the bridge. Default '10.0.3.0/24'.

 * lxc_networking_nat_dhcp_range
  DHCP range, comman-separated. Default '10.0.3.2,10.0.3.254'.

 * lxc_networking_nat_max_hosts
  Maximum number of hosts to be assigned by the DHCP server. Default 253.

 * lxc_networking_nat_dns_domain
  DNS domain to be assigned by the DHCP server. Default undef.

 * lxc_networking_nat_dhcp_conf
  Configuration file to be used for LXC's DHCP server. Default undef.

 * lxc_networking_nat_dhcp_options
  A hash with DHCP specific options, it will be used to create
  the file pointed by $networking_nat_dhcp_conf. The end result
  will be in the format key=value. Default undef.

 * lxc_networking_nat_update_dnsmasq
  Whether to update system-wide dnsmasq instance to avoid it binding
  on $lxc_networking_nat_bridge. Default false.

 * lxc_networking_nat_dnsmasq_conf
  System-wide dnsmasq configuration file, where except-interface setting
  will be modified with $lxc_networking_nat_bridge value. Default
  /etc/dnsmasq.d/lxc.


* `lxc::install`: This class manages the installation of lxc tools, bindings and dependencies.

* `lxc::service`: This class manages LXC service state.

* `lxc::networking::containers`: This class manages the default networking settings for containers.

* `lxc::networking::nat`: This class manages the host networking settings to create a Nat'ed bridge.

* `lxc::sources::precise`: This class manages the LXC PPA for Ubuntu 12.04.


### Resources

#### lxc

* Defines the container itself, allows the following parameters/properties:
  * name: container's name.
  * template: template to be used during container creation. Default 'ubuntu'.
  * template_options: array with template's extra options. User must make sure they are valid.
  * timeout: timeout (in seconds) to wait for container opertions to complete. Default 10s.
  * storage_backend: dir, lvm, btrfs, loop  or best. Default 'dir'.
  * storage_options: options to be passed to the chosen storage backend.
  * state: running, stopped or frozen. Default running.
  * restart: whether to restart the container after applying network configuration. Default false.
  * autostart: enable/disable starting the container at boot time. Default false.
  * autostart_delay: time to wait before starting next container.
  * autostart_order: position on which the container will be started.
  * groups: array with all the container's groups.


#### lxc_interface

* Defines network interfaces and allows the following paramters/properties:
  * name: Just a name...(public, private, ...)
  * container: container's name.
  * index: index number for the interface.
  * device_name: eth0, eth1, ...
  * link: host interface where to link the container interface.
  * vlan_id: VLAN ID.
  * macvlan_mode: private, vepa or bridge.
  * type: defaults to veth.
  * ipv4: IPv4 address (can be string or array).
  * ipv4_gateway: container's default gateway.
  * hwaddr: MAC.
  * restart: whether to restart the container after applying configuration.

## Usage

```Puppet
# lxc class defining NAT'ed network.
class { 'lxc':
  lxc_networking_nat_address        => '10.0.4.1',
  lxc_networking_nat_mask           => '255.255.255.0',
  lxc_networking_nat_network        => '10.0.4.0/24',
  lxc_networking_nat_dhcp_range     => '10.0.4.2,10.0.4.254',
}


# Create ubuntu_test container based on ubuntu template, set its state to
# running, using as storage the VG vg00 and LV ubuntu_test01.
lxc { 'ubuntu_test':
  ensure           => present,
  state            => running,
  autostart        => true,
  template         => 'ubuntu',
  template_options => ['--mirror','http://de.archive.ubuntu.com/ubuntu'],
  storage_backend  => 'lvm',
  storage_options  => {'vgname' => 'vg00', 'lvname' => 'ubuntu_test01'},
}

# Will configure eth1 on container 'ubuntu_test', with two different IP addresses
lxc_interface { 'public':
  ensure       => present,
  device_name  => 'eth0',
  container    => 'ubuntu_test',
  index        => 0,
  link         => 'lxcbr0',
  type         => 'veth',
  ipv4         => '10.0.3.2/24',
  ipv4_gateway => '10.0.3.1',
  restart      => true,
}

lxc_interface { 'private':
  device_name => 'eth1',
  ensure      => present,
  container   => 'ubuntu_test',
  index       => 1,
  link        => 'lxcbr1',
  type        => 'veth',
  ipv4        => ['192.168.200.5/16','192.168.100.10/24'],
  restart     => true,
}
```

## NOTES

 * Precise uses by default Ruby 1.8 and seems Puppet is not able to load new gems while applying
   the catalog, in this case, the resources this module provides will be available after
   applying a catalog with the lxc class included.

 * All the networking settings in ```lxc_interface``` are only applied/checked to/from the
   container's configuration file, for them to take effect the container must be restarted
   (stopped/started), use ```restart => true``` if that's what you need.

## TODO

* Add support for current CentOS releases.
* Add lxc-cgroup provider.
* Get rid of duplications.

## Limitations

The module lxc only works for Ubuntu 14.04 and 12.04, on other platforms with Ruby LXC
bindings installed, the types should work as expected.

## Contributions

Any contribution will be more than welcomed, specially in tests and Ruby parts,
I've tried to do my best, but it's far from perfect.

From version 0.2.0, a development branch is included in module's repository and all the
contributions should be made against it.

If a new feature is added, please, write the tests for it.

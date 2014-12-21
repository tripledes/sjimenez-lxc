# lxc

[![Build Status](https://travis-ci.org/tripledes/sjimenez-lxc.png?branch=master)](https://travis-ci.org/tripledes/sjimenez-lxc)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Resources](#resources)
4. [Usage](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Contributions](#contributions)
7. [NOTES](#notes)
8. [TODO](#todo)

## Overview

This module handles LXC (Linux Containers) from Puppet.
It is being developed and tested under Ubuntu 14.04/12.04 and Puppet >= 3.6.2.

## Module Description

The module installs LXC tools, LXC Ruby bindings and manages LXC service.

The bindings are needed for defining containers as the module includes types and
providers for container management.

For more information about LXC visit: [linuxcontainers.org](https://linuxcontainers.org/).

## Resources

### lxc

* Defines the container itself, allows the following parameters/properties:
  * name: container's name.
  * template: template to be used during container creation.
  * template_options: array with template's extra options. Use must make sure they are valid.
  * timeout: timeout (in seconds) to wait for container opertions to complete.
  * storage_backend: dir, lvm, btrfs, loop  or best.
  * storage_options: options to be passed to the chosen storage backend.
  * state: running, stopped or frozen.
  * restart: whether to restart the container after applying network configuration.
  * autostart: enable/disable starting the container at boot time.
  * autostart_delay: time to wait before starting next container.
  * autostart_order: position on which the container will be started.
  * groups: array with all the container's groups.


### lxc_interface

* Defines network interfaces and allows the following paramters/properties:
  * name: eth0, eth1...
  * container: container's name.
  * index: index number for the interface.
  * link: host interface where to link the container interface.
  * vlan_id: VLAN ID.
  * macvlan_mode: private, vepa or bridge.
  * type: defaults to veth.
  * ipv4: IPv4 address (can be string or array).
  * hwaddr: MAC.
  * restart: whether to restart the container after applying configuration.

## Usage

```Puppet
# Include lxc class
include 'lxc'

# Create ubuntu_test container based on ubuntu template, set its state to
# running, configure its network to IP address 10.0.3.2/24 and default gateway
# 10.0.3.1, using as storage the VG vg00 and LV ubuntu_test01.
lxc { 'ubuntu_test':
  ensure          => running,
  template        => 'ubuntu',
  template_options => ['--mirror','http://de.archive.ubuntu.com/ubuntu'],
  ipv4            => '10.0.3.2/24',
  ipv4_gateway    => '10.0.3.1',
  storage_backend => 'lvm',
  storage_options => {'vgname' => 'vg00', 'lvname' => 'ubuntu_test01'},
}

# Will configure eth1 on container 'ubuntu_test', with two different IP addresses
lxc_interface { 'public':
  name         => 'eth0',
  ensure       => present,
  container    => 'ubuntu_test',
  index        => 0,
  link         => 'lxcbr0',
  type         => 'veth',
  ipv4         => '10.0.3.2/24',
  ipv4_gateway => '10.0.3.1',
  restart      => true,
}

lxc_interface { 'private':
  name      => 'eth1',
  ensure    => present,
  container => 'ubuntu_test',
  index     => 1,
  link      => 'lxcbr1',
  type      => 'veth',
  ipv4      => ['192.168.200.5/16','192.168.100.10/24'],
  restart   => true,
}
```

## NOTES
* Precise uses by default Ruby 1.8 and seems Puppet is not able to load new gems while applying
  the catalog, in this case, the types this module provides will be available on the 2nd
  Puppet run after the bindings are installed.

* All the networking settings in ```lxc_interface``` are only applied/checked to/from the
  container's configuration file, for them to take effect the container must be restarted
  (stopped/started), use ```restart => true``` if that's what you need.

## TODO

* Add support for current CentOS releases.
* Add lxc-cgroup provider.
* Get rid of duplications.
* Fix beaker test for Ubuntu Precise.

## Limitations

For now, the class lxc only works for Ubuntu 14.04, on other platforms with Ruby LXC
bindings installed, the types should work as expected.

The current state of the provider is quite basic, meaning it creates the container based
on the template assigned and manages its state. It doesn't do any further configuration as
IPs, shared folders, ... These features might come later.

## Contributions

Any contribution will be more than welcomed, specially in tests and Ruby parts,
I've tried to do my best, but it's far from perfect.

From version 0.2.0, a development branch is included in module's repository and all the
contributions should be made against it.

If a new feature is added, please, write the tests for it.

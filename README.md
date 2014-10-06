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
It is being developed and tested under Ubuntu 14.04 and Puppet >= 3.6.2.

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
  * timeout: timeout (in seconds) to wait for container opertions to complete.
  * storage_backend: dir, lvm, btrfs, loop  or best.
  * storage_options: options to be passed to the chosen storage backend.
  * state: running, stopped or frozen.
  * ipv4: IPv4 address for eth0.
  * ipv4_gateway: default IPv4 gateway.

### lxc_interface

* Defines network interfaces other than eth0 and allows the following paramters/properties:
  * name: eth1, eth2...
  * container: container's name.
  * index: index number for the interface.
  * link: host interface where to link the container interface.
  * vlan_id: VLAN ID.
  * macvlan_mode: private, vepa or bridge.
  * type: defaults to veth.
  * ipv4: IPv4 address.
  * hwaddr: MAC.

## Usage

```Puppet
include 'lxc'

lxc { 'ubuntu_test':
  ensure          => running,
  template        => 'ubuntu',
  ipv4            => '10.0.3.2/24',
  ipv4_gateway    => '10.0.3.1',
  storage_backend => 'lvm',
  storage_options => {'vgname' => 'vg00', 'lvname' => 'ubuntu_test01'},
}

lxc_interface { 'eth1':
  ensure    => present,
  container => 'ubuntu_test',
  index     => 1,
  link      => 'lxcbr0',
  type      => 'veth',
  ipv4      => '192.168.200.5/16',
}

```

## NOTES

* All the networking settings, both in ```lxc``` and ```lxc_interface``` are only
applied to the container's configuration file, for it to take effect the
container must be restarted (stopped/started), use ```restart => true```.

* ```ipv4``` parameter on ```lxc``` provider might not work as expected if the
template in use configures network on the container to use DHCP. The container
will have 2 IPs on the first interface.

## TODO

* Add support for Ubuntu precise.
* Add support for current CentOS releases.
* Add lxc-cgroup provider.
* Get rid of duplications.
* Add Beaker to the game.

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

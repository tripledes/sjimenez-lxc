# lxc

[![Build Status](https://travis-ci.org/tripledes/sjimenez-lxc.png?branch=master)](https://travis-ci.org/tripledes/sjimenez-lxc)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Contributions](#contributions)
6. [TODO](#todo)

## Overview

This module handles LXC (Linux Containers) from Puppet.
It is being developed and tested under Ubuntu 14.04 and Puppet 3.6.2.

## Module Description

The module installs LXC tools, LXC Ruby bindings and manages LXC service.

The bindings are needed for defining containers as the module includes types and
providers for container management.

For more information about LXC visit: [linuxcontainers.org](https://linuxcontainers.org/).

## Usage

```Puppet
include 'lxc'

lxc { 'ubuntu_test':
  ensure   => running,
  template => 'ubuntu',
}
```

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

## TODO

* Add support for Ubuntu precise.
* Add support for current CentOS releases.
* Improve current lxc-container provider.
* Add lxc-cgroup provider.
* Add Beaker to the game.

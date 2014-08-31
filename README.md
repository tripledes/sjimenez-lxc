# lxc

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What lxc affects](#what-lxc-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with lxc](#beginning-with-lxc)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

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

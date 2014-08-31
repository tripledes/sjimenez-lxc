#
class lxc::params {
  case $::operatingsystem {
    'Ubuntu': {
      if $::operatingsystemrelease == '14.04' {
        $lxc_ruby_bindings_provider = gem
        $lxc_ruby_bindings_package = 'ruby-lxc'
        $lxc_ruby_bindings_version = '1.2.0'
        $lxc_lxc_package = 'lxc'
        $lxc_lxc_version = '1.0.5-0ubuntu0.1'
        $lxc_lxc_service = 'lxc'
        $lxc_lxc_service_ensure = running
        $lxc_lxc_service_enabled = true
        $lxc_ruby_bindings_gem_deps = ['build-essential', 'ruby-dev', 'lxc-dev']
      } else {
        fail('Only Ubuntu 14.04 is supported by this module.')
      }
    }
    default: {
      fail("${::operatingsystem} is not supported by this module.")
    }
  }
}


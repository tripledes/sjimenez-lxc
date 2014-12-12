#
class lxc::params {
  case $::operatingsystem {
    'Ubuntu': {
      case $::lsbdistcodename {
        'trusty': {
          # Nothing to do here...
        }
        'precise': {
          contain 'lxc::sources::precise'
        }
        default: {
          fail("Only Ubuntu ${::lsbdistcodename} is not supported by ${module_name}.")
        }
      }
    }
    default: {
      fail("${::operatingsystem} is not supported by this module.")
    }
  }

  $lxc_ruby_bindings_provider = gem
  $lxc_ruby_bindings_package = 'ruby-lxc'
  $lxc_ruby_bindings_version = '1.2.0'
  $lxc_lxc_package = 'lxc'
  $lxc_lxc_version = latest
  $lxc_lxc_service = 'lxc'
  $lxc_lxc_service_ensure = running
  $lxc_lxc_service_enabled = true

  $lxc_ruby_bindings_gem_deps = [
    'build-essential', 'ruby-dev', 'lxc-dev'
  ]

}


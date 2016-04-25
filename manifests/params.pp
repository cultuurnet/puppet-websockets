# == Class websockets::params
#
# This class is meant to be called from websockets.
# It sets variables according to platform.
#
class websockets::params {
  case $::operatingsystem {
    'Ubuntu': {
      case $::operatingsystemrelease {
        '14.04': {
          $ensure = 'present',
          $package_ensure = 'present',
          $config_user = 'www-data',
          $config_group = 'www-data',
          $service_manage = true,
          $service_enable = true,
          $service_ensure = 'running'
        }
        default: {
          fail("Ubuntu ${::operatingsystemrelease} not supported")
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

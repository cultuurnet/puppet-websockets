class websockets (
  $package_name,
  $config_file,
  $config_source,
  $ensure = $::websockets::params::ensure,
  $package_version = $::websockets::params::package_version,
  $config_user = $::websockets::params::config_user,
  $config_group = $::websockets::params::config_group,
  $service_manage = $::websockets::params::service_manage,
  $service_name = $package_name,
  $service_enable = $::websockets::params::service_enable,
  $service_ensure = $::websockets::params::service_ensure
) inherits websockets::params {
  case $ensure {
    'absent': {
      file { $config_file:
        ensure => $ensure
      }

      package { $package_name:
        ensure => $ensure
      }

      File[$config_file] -> Package[$package_name]
    }
    'present': {
      package { $package_name:
        ensure  => $package_version,
        require => Apt::Source['cultuurnet-tools']
      }

      file { $config_file:
        ensure => 'file',
        owner  => $config_user,
        group  => $config_group,
        source => $config_source
      }

      if $service_manage {
        service { $service_name:
          ensure => $service_ensure,
          enable => $service_enable
        }

        File[$config_file] ~> Service[$service_name]
      }

      Package[$package_name] -> File[$config_file]
    }
    default: {
      fail("Invalid value ${ensure} passed for parameter ensure. Value should be present or absent")
    }
  }
}

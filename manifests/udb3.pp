class websockets::udb3 (
  $config_source,
  $ensure = $::websockets::params::ensure
  $package_ensure = $::websockets::params::package_ensure
  $config_user = $::websockets::params::config_user,
  $config_group = $::websockets::params::config_group,
  $service_manage = $::websockets::params::service_manage,
  $service_enable = $::websockets::params::service_enable,
  $service_ensure = $::websockets::params::service_ensure
) inherits websockets::params {

  class { '::websockets':
    package_name   => 'udb3-websockets',
    config_file    => '/var/www/udb-websockets/config.json',
    config_source  => $config_source,
    ensure         => $ensure,
    package_ensure => $package_ensure,
    config_user    => $config_user,
    config_group   => $config_group,
    service_manage => $service_manage,
    service_name   => 'udb3-websockets',
    service_enable => $service_enable,
    service_ensure => $service_ensure
  }
}

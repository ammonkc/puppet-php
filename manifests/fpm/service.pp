# Class: php::fpm::service
#
# This class installs PHP-FPM for Apache
#
# Parameters:
# - $phpfpm_name
# - $service_enable [bool]
#
# Actions:
#   - Manage PHP-FPM Service
#
# Requires:
#
# Sample Usage:
#
class php::fpm::service (
    $service_enable   = $php::fpm::params::service_enable,
    $phpfpm_name      = $php::fpm::params::phpfpm_name,
) inherits php::fpm::params {

  # true/false is sufficient for both ensure and enable
  validate_bool($service_enable)

  service { 'php-fpm':
    ensure      => $service_enable,
    name        => $phpfpm_name,
    enable      => $service_enable,
    require     => Package['php-fpm'],
    subscribe   => Package['php-fpm'],
  }
}

# Class: phpfpm::service
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
class phpfpm::service (
    $service_enable = true,
    $phpfpm_name    = 'php-fpm',
) inherits phpfpm::params {

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

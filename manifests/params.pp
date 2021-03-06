# Class: php::params
#
# This class manages PHP parameters
#
# Parameters:
# - The $user that Apache runs as
# - The $group that Apache runs as
# - The $apache_name is the name of the package and service on the relevant
#   distribution
# - The $php_package is the name of the package that provided PHP
# - The $ssl_package is the name of the Apache SSL package
# - The $apache_dev is the name of the Apache development libraries package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class php::params {
    if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {
        $service_enable = true
        $php_name       = 'php'
        $phpfpm_name    = 'php-fpm'
        $fastcgi_name   = 'mod_fastcgi'
        $httpd_dir      = '/etc/httpd'
        $conf_dir       = "${httpd_dir}/conf"
        $mod_dir        = "${httpd_dir}/mod.d"
        $confd_dir      = "${httpd_dir}/conf.d"
    } elsif $::osfamily == 'debian' {

    } else {
        fail("Class['php::params']: Unsupported operatingsystem: $operatingsystem")
    }
}

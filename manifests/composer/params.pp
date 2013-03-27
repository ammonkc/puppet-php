# Class: php::composer::params
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
class php::composer::params {
    if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {
        $target_dir      = '/usr/local/bin'
        $composer_file   = 'composer'
        $download_method = 'curl'
        $logoutput       = false
        $tmp_path        = '/opt'
        $php_package     = 'php-cli'
        $owner           = 'root'
        $group           = 'root'
        $self_update     = false
    } elsif $::osfamily == 'debian' {
        $target_dir      = '/usr/local/bin'
        $composer_file   = 'composer'
        $download_method = 'curl'
        $logoutput       = false
        $tmp_path        = '/home/vagrant'
        $php_package     = 'php5-cli'
    } else {
        fail("Class['apache::params']: Unsupported operatingsystem: $operatingsystem")
    }
}

# Class: phpfpm::cli
#
# Command Line Interface PHP. Useful for console scripts, cron jobs etc.
# To customize the behavior of the php binary, see php::ini.
#
# Sample Usage:
#  include phpfpm::cli
#
class phpfpm::cli ( $inifile = '/etc/php.ini' ) {
  package { 'php-cli':
    ensure  => installed,
    require => File[$inifile],
  }
}

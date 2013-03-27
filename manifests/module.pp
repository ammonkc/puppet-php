# Define: phpfpm::module
#
# Manage optional PHP modules which are separately packaged.
# See also php::module:ini for optional configuration.
#
# Sample Usage :
#  phpfpm::module { [ 'ldap', 'mcrypt', 'xml' ]: }
#  phpfpm::module { 'odbc': ensure => absent }
#  phpfpm::module { 'pecl-apc': }
#
define phpfpm::module ( $ensure = installed ) {
  package { "php-${title}":
    ensure => $ensure,
  }
}


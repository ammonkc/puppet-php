# Define: phpfpm::module::ini
#
# Configuration for optional PHP modules which are separately packaged.
# See also php::module for package installation.
#
# Sample Usage :
#  phpfpm::module::ini { 'xmlreader': pkgname => 'xml' }
#  phpfpm::module::ini { 'pecl-apc':
#      settings => {
#          'apc.enabled'      => '1',
#          'apc.shm_segments' => '1',
#          'apc.shm_size'     => '64',
#      }
#  }
#  phpfpm::module::ini { 'xmlwriter': ensure => absent }
#
define phpfpm::module::ini (
  $pkgname  = false,
  $settings = {},
  $zend     = false,
  $ensure   = undef
) {

  # Strip 'pecl-*' prefix is present, since .ini files don't have it
  $modname = regsubst($title , '^pecl-', '', G)

  # Package name
  $rpmpkgname = $pkgname ? {
    false   => "php-${title}",
    default => "php-${pkgname}",
  }

  # INI configuration file
  file { "/etc/php.d/${modname}.ini":
    ensure  => $ensure,
    require => Package[$rpmpkgname],
    content => template('phpfpm/module.ini.erb'),
  }

}


# == Class: php::composer
#
# The parameters for the composer class and corresponding definitions
#
# === Parameters
#
# Document parameters here.
#
# [*target_dir*]
#   The target dir that composer should be installed to.
#   Defaults to ```/usr/local/bin```.
#
# [*composer_file*]
#   The name of the composer binary, which will reside in ```target_dir```.
#
# [*download_method*]
#   Either ```curl``` or ```wget```.
#
# [*logoutput*]
#   If the output should be logged. Defaults to FALSE.
#
# [*tmp_path*]
#   Where the composer.phar file should be temporarily put.
#
# [*php_package*]
#   The Package name of tht PHP CLI package.
#
# === Authors
#
# Ammon Casey <ammonkc@gmail.com>
#
class php::composer(
  $target_dir      = $php::composer::params::target_dir,
  $composer_file   = $php::composer::params::composer_file,
  $download_method = $php::composer::params::download_method,
  $logoutput       = $php::composer::params::logoutput,
  $tmp_path        = $php::composer::params::tmp_path,
  $php_package     = $php::composer::params::php_package,
  $owner           = $php::composer::params::owner,
  $group           = $php::composer::params::group,
  $self_update     = $php::composer::params::self_update
) inherits php::composer::params {

  Exec { path => "/bin:/usr/bin/:/sbin:/usr/sbin:$target_dir" }

  if defined(Package[$php_package]) == false {
    package { $php_package: ensure => present, }
  }

  # download composer
  if $download_method == 'curl' {

    if defined(Package['curl']) == false {
      package { 'curl': ensure => present, }
    }

    exec { 'download_composer':
      command     => 'curl -s http://getcomposer.org/installer | php',
      cwd         => $tmp_path,
      require     => Package['curl', $php_package],
      creates     => "$tmp_path/composer.phar",
      logoutput   => $logoutput,
    }
  }
  elsif $download_method == 'wget' {

    if defined(Package['wget']) == false {
      package {'wget': ensure => present, }
    }

    exec { 'download_composer':
      command     => 'wget http://getcomposer.org/composer.phar -O composer.phar',
      cwd         => $tmp_path,
      require     => Package['wget'],
      creates     => "$tmp_path/composer.phar",
      logoutput   => $logoutput,
    }
  }
  else {
    fail("The param download_method $download_method is not valid. Please set download_method to curl or wget.")
  }

  # check if directory exists
  file { $target_dir:
    ensure      => directory,
  }

  # move file to target_dir
  file { "$target_dir/$composer_file":
    ensure      => present,
    source      => "$tmp_path/composer.phar",
    require     => [ Exec['download_composer'], File[$target_dir], ],
    group       => $group,
    owner       => $owner,
    mode        => '0755',
  }

  # update composer binary
  if $self_update {
    exec { 'composer-update':
      command => "${composer_file} self-update",
      path    => "/usr/bin:/bin:/usr/sbin:/sbin:${target_dir}",
      user    => $owner,
      require => File["$target_dir/$composer_file"],
    }
  }
}

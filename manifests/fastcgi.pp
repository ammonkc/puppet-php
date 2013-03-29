# class php::fastcgi
#
class php::fastcgi (
    $fastcgi_name   = $php::fastcgi::params::fastcgi_name,
    $confd_dir      = $php::fastcgi::params::confd_dir,
) inherits php::fastcgi::params {
    package { 'fastcgi':
        ensure  => "installed",
        name    => $fastcgi_name,
        require => Package['httpd'],
    }
    file { "${confd_dir}/fastcgi.conf":
        ensure  => present,
        content => template('php/fastcgi.conf.erb'),
    }
    file { "/usr/lib/cgi-bin":
        ensure  => "directory",
        owner   => "root",
        group   => "root",
        mode    => 0755
    }
}

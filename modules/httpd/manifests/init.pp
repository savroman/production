# httpd
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include httpd
class httpd {
  package {'httpd':
    ensure => installed,
    before => File['/etc/httpd/edit_httpd.sh'],
  }

  file { '/etc/httpd/edit_httpdconf.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => file( 'httpd/edit_httpdconf.sh'),
    notify  => Exec['edit_httpd.conf'],
  }

  exec {'edit_httpd.conf':
    command  => '/etc/httpd/edit_httpdconf.sh',
    path     => '/bin:/sbin:/usr/bin:/usr/sbin'
  }

  service {'httpd':
    ensure    => running,
    enable    => true,
    subscribe => Exec['edit_httpd.conf'],
  }
}

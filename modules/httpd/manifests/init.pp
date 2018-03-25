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
    #before => File['/etc/httpd.conf'],
  }
  #file {'/etc/httpd.conf':
  #  ensure  => file,
  #  owner   => 'root',
  #  content => template('httpd/httpd.conf.epp'),
  #}
  service {'httpd':
    ensure    => running,
    enable    => true,
    #subscribe => File['/etc/httpd.conf'],
  }
}

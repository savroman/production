# rpmrepo::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include rpmrepo::install
class rpmrepo::install {
  include httpd

  class {'base::firewall': 
    dport => '80',
  }

  file { '/var/www/html/repo':
    ensure => directory,
    mode => '0644',
  }

  #file { '/etc/httpd/conf.d/welcome.conf':
    #ensure => absent,
    #before
  #}

}

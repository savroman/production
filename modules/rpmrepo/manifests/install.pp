# rpmrepo::install
# ==========================
#
# Install software required to build a repositiry
#
# @summary This class add to node next things:
#  - Apache Web Server
#  - createrepo tool
#
# @example
#   include rpmrepo::install
class rpmrepo::install {
  include httpd

  file { '/var/www/html/repo':
    ensure => directory,
    mode   => '0644',
  }

  firewall::openport {'rpmrepo':
    dport => '80',
  }

  package { 'createrepo':
    ensure => installed,
  }
  #file { '/etc/httpd/conf.d/welcome.conf':
    #ensure => absent,
    #before
  #}

}

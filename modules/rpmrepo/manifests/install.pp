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

  $fpm_needs= ['ruby', 'ruby-devel', 'gcc', 'make', 'rpm-build', 'rubygems',]

  package { $fpm_needs:
    ensure => latest,
  }

  package { 'fpm':
    ensure          => installed,
    provider        => 'gem',
    #install_options => ['--no-ri', '--no-rdoc'],
  }
}

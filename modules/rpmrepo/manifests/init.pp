# rpmrepo
# ===================
#
# Crete custom rpm repository for project build artifacts
#
# @summary A short summary of the purpose of this class
#
# @example
#   include rpmrepo
class rpmrepo (
  $repo_url = '/var/www/html/repo',
  $update   = '60', 
  ) {
  include rpmrepo::install

  file { $repo_url:
    ensure => directory,
    mode   => '0755',
  }

  firewall::openport {'rpmrepo':
    dports => '80',
  }
}

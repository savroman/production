# rpmrepo
# ===================
#
# Crete custom rpm repository for project build artifacts
#
# @summary A short summary of the purpose of this class
#
# @example
#   include rpmrepo
class rpmrepo {
  include rpmrepo::install

  firewall::openport {'rpmrepo':
    dports => '80',
  }
}

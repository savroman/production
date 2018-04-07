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

  $tools = ['createrepo','yum-utils']

  package { "${tools}":
    ensure   => installed,
  }
}

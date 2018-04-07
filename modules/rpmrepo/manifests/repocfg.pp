# == Class: rpmrepo::repocfg
# ==========================
#
# Add yum repositiry to config
#
# Include this class to add our local yum repositiry on your node
#
# @example
#   include rpmrepo::repocfg
#
#
class rpmrepo::repocfg {
  yumrepo { 'repo':
    enabled  => 1,
    descr    => $rpmrepo::repo_name,
    baseurl  => "http://${rpmrepo::repo_domain}",
    gpgcheck => 0,
    priority => 1,
  }
}

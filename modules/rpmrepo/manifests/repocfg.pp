# == Class: rpmrepo::repocfg
# ==========================
#
# Add yum repositiry to config
#
# Include this class to add our local yum repositiry
#
# @example
#   include rpmrepo::repocfg
#
#
class rpmrepo::repocfg {
  yumrepo { 'repo':
    enabled  => 1,
    descr    => 'Our local repopository',
    baseurl  => 'http://repo.if083/',
    gpgcheck => 0,
  }

}

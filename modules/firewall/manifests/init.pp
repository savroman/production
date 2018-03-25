# Class: base::firewall
# ===========================
#
# Use it to open ports on severs
#
# @ param dport
#    enter the number of port you wish to open
#
# @example
#    class { 'base::firewall':
#      dport => '80',
#    }


# == Define: base::firewall
#
# == Class: firewall
#
class firewall {
  service { "firewalld":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    }
}

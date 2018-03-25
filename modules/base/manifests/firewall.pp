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
define base::firewall (
  $dport='',
  ) {

  exec { "firewall-cmd${title}":
    command => "firewall-cmd --zone=public --add-port=${dport}/tcp --permanent",
    path    => "/usr/bin/",
    before  => Exec["firewall-reload${title}"],
  }

  exec { "firewall-reload${title}":
    command => "firewall-cmd --reload",
    path    => "/usr/bin/",
    before  => Service["firewalld${title}"],
  }

  service { "firewalld${title}":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    subscribe  => Exec["firewall-cmd${title}"],
  }
}

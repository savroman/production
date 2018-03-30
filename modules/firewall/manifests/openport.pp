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
define firewall::openport (
  $dports='',
  ) {
  require firewall

  $dports.each |String $dport| {
    exec { "firewall-cmd-${dport}":
      command => "firewall-cmd --zone=public --add-port=${dport}/tcp --permanent",
      path    => "/usr/bin/",
      before  => Exec["firewall-reload${title}"],
    }
  }

  exec { "firewall-reload${title}":
    command => "firewall-cmd --reload",
    path    => "/usr/bin/",
  }
}

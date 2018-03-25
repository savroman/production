# Class: base
# ===========================
#
# Update os & install useful packeges
#
# @ param dport
#    enter the number of port you wish to open
#

class base {

  $packages = ['tree', 'mc', 'net-tools', 'wget', 'git']

  if $::osfamily == 'RedHat' {
    exec { 'yum-update':
      command => '/usr/bin/yum -y update'
    }
  }

  elsif $::osfamily == 'Debian' {
    exec { 'apt-update':
      command => '/usr/bin/apt-get -y update'
    }
  }

  package { $packages:
    ensure       => installed,
  }
}

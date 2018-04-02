# Class: base
#
#

class base {

if $::osfamily == 'RedHat' {
  exec { 'yum-update':
      command      => '/usr/bin/yum -y update'
      }
}

elsif $::osfamily == 'Debian' {

    exec { 'apt-update':
      command      => '/usr/bin/apt-get -y update'
      }

}

$packages = ['tree', 'mc', 'net-tools']
package { $packages:
    ensure       => installed,
}
}

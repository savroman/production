class profile::basenode {

  include motd
  include ntp
  include rpmrepo
  # OS parameters for Update
  Exec {
      path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
  }
  if $::osfamily == 'RedHat' {
    exec { 'RedHat':
          command => '/usr/bin/yum -y update',
    }
  }
  elsif $::osfamily == 'Debian' {
    exec { 'Debian':
          command => '/usr/bin/apt-get -y update',
    }
  }

  # Start packages
  $packages = ['tree', 'mc', 'net-tools', 'wget']
  package { $packages:
    ensure       => installed,
  }

# Configure ssh_user
  sshuser { 'if083':
    ssh_user     => 'if083',
    key          => file('profile/service.pub'),
  }


# Configure rpmrepo
  yumrepo { 'soft':
    enabled  => 1,
    descr    => "Our repo",
    baseurl  => "http://repo.if083/soft/",
    gpgcheck => 0,
    priority => 1,
  }


# Configure rsyslog
  rsyslog::config { 'secure':
    log_name     => '/var/log/secure',
    log_tag      => 'sys_',
    app_name     => 'secure',
    severity     => 'info',
  }

  rsyslog::config { 'messages':
    log_name     => '/var/log/messages',
    log_tag      => 'sys_',
    app_name     => 'messages',
    severity     => 'info',
  }
}

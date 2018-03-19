class profile::web::tomcat {
  include tomcat
   # create firewall rules
  
  exec { 'firewall-cmd':
    command => 'firewall-cmd --zone=public --add-port=8080/tcp --permanent',
    path => '/usr/bin/',
    before      => Exec['firewall-reload'],
  }
  exec { 'firewall-reload':
    command => 'firewall-cmd --reload',
    path    => '/usr/bin/',
    before      => Service['firewalld'],
  }
  service { 'firewalld':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    subscribe  => Exec['firewall-cmd'],
  }
}

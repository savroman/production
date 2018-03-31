class profile::tomcat (  
    $dports = ['80', '8080'],
) {

  include java8
  include tomcat
  include firewall

  firewall::openport {'tomcat':
    dports => $dports,
  }

  exec { 'setenforce':
    command => "setenforce 0",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require => Service['firewalld'],
  }
}

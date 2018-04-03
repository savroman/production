class profile::tomcat(
  String $man_user       = 'manager',  
  String $password       = 'manager', 
  String $host_name      = 'bugtrckr.if083',
  String $docBase        = 'BugTrckr-0.5.0-SNAPSHOT',
  $dports         = ['80', '8080'],
  $ssh_user       = 'if083',
  $ssh_group      = 'wheel',
  $ssh_password   = 'EC6365332FBD2AC606392FB5D9964BED142FDFC06EA788ACD281E1B9C66C192E',
)
{
  
  include java8
  include tomcat
  include firewall
  

  base::ssh_user { $ssh_user:
    ssh_user      => $ssh_user,
    ssh_password  => $ssh_password,
    ssh_group     => $ssh_group,
  }
  firewall::openport {'tomcat':
    dports        => $dports,
  }

  exec { 'setenforce':
    command       => "setenforce 0",
    path          => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require       => Service['firewalld'],
  }
}

class profile::jenkins::master {

  include java8
  include httpd
  include firewall
  include jenkins

  $dports = ['80', '8080']

  class { 'tomcat':
    tomcat_version => '7.0.76-3.el7_4',
    dns_name       => 'jenkins.if083',
    docBase        => 'jenkins',
    man_user       => 'manager',
    password       => 'manager',
  }

  # Configure mod_proxy
  #class { 'profile::webapp::proxy':
  #}

  # Configure firewall
  firewall::openport { 'jenkins':
    dports => $dports,
  }

  # Configure selinux
  exec { 'setenforce':
    command             => 'setenforce 0',
    path                => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require             => Service['firewalld'],
  }
  # Apps repo section
  class { 'rpmrepo':
    repo_domain => $facts[hostname],
    repo_name   => 'Our application buils',
    repo_dirs   => ['apps','apps/latest'],
  }

  httpd::vhost { 'apprepo':
    port          => '80',
    document_root => '/var/www/html',
    user          => 'root',
    group         => 'root',
  }

  rpmrepo::updaterepo { 'apps':
    repo_dir    => "/var/www/html/apps",
    update_min  => '*/1',
  }
}

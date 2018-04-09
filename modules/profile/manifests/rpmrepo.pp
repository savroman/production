class profile::rpmrepo {
  class { 'rpmrepo':
    repo_domain => $facts[hostname],
    repo_name   => 'Our local repopository',
    repo_dirs   => ['soft','apps'],
  }

  include httpd

  httpd::vhost { 'repo':
    port          => '80',
    document_root => '/var/www/html',
  }

  firewall::openport {'rpmrepo':
    dports => ['80'],
  }
  
  rpmrepo::updaterepo { 'soft':
    repo_dir    => "/var/www/html/soft",
    update_min  => '15',
    update_hour => '21',
  }
}

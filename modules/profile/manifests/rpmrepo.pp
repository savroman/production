class profile::rpmrepo {
  class rpmrepo {
    repo_domain => "repo.if083",
    repo_name   => 'Our local repopository',
  }

  $repo_conf = @(CONF)
  <VirtualHost *:80>
    ServerName repo.if083
    DocumentRoot /var/www/repo.if083
  </VirtualHost>
      | CONF

  httpd::addcfg { 'localrepo'
    conf_name => "repo.conf",
    conf_text => $repo_conf,
  }

}

class profile::mysqlserver::master {
  $mysql_root_password = "a8+?treAvpDa" # My root password
  $mysql_version       = "5.7" # Provide the Mysql Version. You can set 5.7 or 5.6
  $mysql_serverid      = "1" # Provide the Server ID = 1.2.3.... etc
  $port                = ['3306'] # can also be defined under my.cnf
  $bind_address        = "0.0.0.0"  # can also be defined under my.cnf
  $is_master           = true # True if the node is master
  $replica_user        = "replication" # For master, what is the replication account
  $replica_password    = "Pr0m3Teus!" # Replication User password
  $repo_url            = "http://repo.mysql.com/yum/mysql-${mysql_version}-community/el/7/x86_64/"
  $repo_descr          = "MySQL $mysql_version Community Server"

firewall::openport {'mysqlmaster':
  dports => $port,
}

yumrepo { 'mysql-repo':
  descr    => $repo_descr,
  enabled  => 1,
  baseurl  => $repo_url,
  gpgcheck => 0,
}

class { 'mysql':
  mysql_root_password => $mysql_root_password,
  mysql_serverid      => $mysql_serverid,
  bind_address        => $bind_address,
}

if $is_master {
    mysql::users { '${replica_user}': 
      table     => '*', # GRANT ALL ON ${table}.*
      user      => $replica_user,
      user_pass => $replica_password,
      host      => '%',
      grant     => 'REPLICATION SLAVE',
    }
  }
  
class {'rsyslog::client':
}
rsyslog::config {'mysql':
  log_name => '/var/log/mysqld.log',
  log_tag  => 'mysql_',
  app_name => 'mysql',
  severity => 'info',
}
}
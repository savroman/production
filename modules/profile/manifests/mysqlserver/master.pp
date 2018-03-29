class profile::mysqlserver::master (
# $serverid               = "1", # Provide the Server ID = 1.2.3.... etc
# $datadir                = "/var/lib/mysql", # can also be defined under my.cnf
  $port                   = "3306", # can also be defined under my.cnf
# $bind_address           = "0.0.0.0",  # can also be defined under my.cnf
  $is_master              = true, # True if the node is master
  $replica_user           = "replication", # For master, what is the replication account
  $replica_password       = "Pr0m3Teus!", # Replication User password
  $replica_password_hash  = '*D36660B5249B066D7AC5A1A14CECB71D36944CBC', # the same replication account password hashed

)
{
include mysql
include firewall

firewall::openport {'mysqlmaster':
    dport => $port,
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
}



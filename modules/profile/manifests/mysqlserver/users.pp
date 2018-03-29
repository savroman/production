class profile::mysqlserver::users {
include mysql

mysql::db { 'bugtrckr':
  database => 'bugtrckr',
  charset  => 'utf8',
  collate  => 'utf8_unicode_ci',
}
mysql::db { 'zabbix_db':
  database => 'zabbix',
  charset  => 'utf8',
  collate  => 'utf8_unicode_ci',
}
mysql::users { 'tomcat': 
  table     => 'bugtrckr', # GRANT ALL ON ${table}.*
  user      => 'tomcat',
  user_pass => 'la_3araZa',
  host      => '%',
  grant     => 'ALL',
}
mysql::users { 'zabbix_user': 
  table     => 'zabbix', # GRANT ALL ON ${table}.*
  user      => 'zabbix',
  user_pass => '3a66ikc_DB',
  host      => '%',
  grant     => 'ALL',
}
}




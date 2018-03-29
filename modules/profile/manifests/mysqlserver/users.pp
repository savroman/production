class profiles::mysqlserver::users {
include mysql

mysql::db { 'bugtrckr':
  database => 'bugtrckr',
  charset  => 'utf8',
  collate  => 'utf8_unicode_ci',
}
mysql::db { 'zabbix':
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
mysql::users { 'zabbix': 
  table     => '*', # GRANT ALL ON ${table}.*
  user      => 'zabbix',
  user_pass => '3a66ikc_DB',
  host      => '%',
  grant     => 'ALL',
}
}




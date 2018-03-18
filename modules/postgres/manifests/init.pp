# Class: postgres
# ===========================
#  This module uses yet for RedHat family OS only
# Copyright
# ---------
#
# Copyright 2018 oleksdiam
#
class postgres (
  $ensure           = 'installed',
  $version          = '9.6',
  $admin_pass       = 'N3WP@55',
  $owner            = 'sonar',
  $db_pass          = 'sonar',
  $dbname           = 'sonar',
  $user_host        = 'localhost',
  $source_url       = 'https://download.postgresql.org/pub/repos/',
  $dport            = '5432',

){
  
  $pgsql            = 'postgresql96'
  $psql_pass        = "${admin_pass}"
  $psql_user        = 'postgres'
  $psql_group       = 'postgres'
  $psql_path        = '/usr/bin/psql'

  Exec {
    path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin',
  }

  case $::osfamily {
    'RedHat', 'Linux': {
      $uri  = 'yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm'
    }
    default: {fail("Unsupported OS: ${::osfamily}.  Implement me?")}
  }

  package { "${source_url}${uri}":
    ensure   => installed,
    provider => 'yum',
  }
  ->
  package { "${pgsql}":
    ensure   => installed,
    provider => 'yum',
  }
  ->
  package { "${pgsql}-server":
    ensure   => installed,
    provider => 'yum',
  }

  exec { 'initdb':
    command  => '/usr/pgsql-9.6/bin/postgresql96-setup initdb',
    # notify       => Service['postgresql-9.6'],
  }  

  file { "/var/lib/pgsql/${version}/data/pg_hba.conf":
    ensure  => file,
    mode    => '0600',
    content => template('postgres/pg_hba.conf.erb'),
    notify  => Service['postgresql-9.6'],
  }

  file { "/var/lib/pgsql/${version}/data/postgresql.conf":
    ensure  => file,
    mode    => '0600',
    content => template('postgres/postgresql.conf.erb'),
    notify  => Service['postgresql-9.6'],
  }

  service { 'postgresql-9.6':
  	enable      => true,
  	ensure      => running,
  	hasrestart  => true,
  	hasstatus   => true,
  	# provider    => 'redhat',
  }

  exec { 'alter_postgre':
    command     => "psql -c \"ALTER USER ${psql_user} WITH PASSWORD '${psql_pass}';\"",
    user        => "${psql_user}",
  }

  ->
  exec { 'createuser':
  	command     => "psql -c \"CREATE USER ${owner};\"",
  	user        => "${psql_user}",
    unless      => "psql -c '\\du' | grep '^  *${owner}  *|'",
  }

  ->
  exec { 'createdb':
  	command     => "psql -c \"CREATE DATABASE ${dbname} WITH OWNER = ${owner};\"",
  	user        => "${psql_user}",
  	require     => Exec['createuser'],
    unless      => "psql -c '\\l' | grep '^  *${dbname}  *|'",
  }
  
  ->
  exec { 'alter_owner':
    command     => "psql -c \"ALTER USER ${owner} with encrypted password '${db_pass}';\"",
    user        => "${psql_user}",
  	require     => Exec['createdb'],
  }

  exec { 'firewall-port':
    command     => "firewall-cmd --zone=public --add-port=${dport}/tcp --permanent",
    notify      => Exec['firewall_reload'],
  }
  ->
  exec { 'firewall-http':
    command     => "firewall-cmd --zone=public --add-service=http --permanent",
    notify      => Exec['firewall_reload'],
  }
  ->
  exec { 'firewall_reload':
    command     => "firewall-cmd --reload",
    # notify      => Service['firewalld'],
  }

  # ->
  # service { 'firewalld':
  #   ensure     => running,
  #   enable     => true,
  #   hasrestart => true,
  #   subscribe  => Exec['firewall-port'],
  # }
}



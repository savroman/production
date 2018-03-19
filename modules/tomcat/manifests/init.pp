# Class: tomcat
#
#
class tomcat {
# resources
$user             = 'tomcat'
$password         = 'tomcat' 
$group            = 'tomcat'
$java_home        = '/usr/java/jdk1.8.0_162/jre'
$catalina_home    = '/usr/share/tomcat'
$catalina_base    = '/var/lib/tomcat/webapps' 
$confdir          = '/etc/tomcat'
$packages         = ['tomcat', 'tomcat-webapps', 'tomcat-admin-webapps']

# config variables for aplication
$tomcat_conf_file     = "$confdir/tomcat.conf"
$server_conf_file     = "$confdir/server.xml"
$host_name            = "bugtrckr.local"
$docBase              = "BugTrckr-0.5.0-SNAPSHOT"
$appdir               = "$catalina_base/$docBase"
$users_conf_file      = "$confdir/tomcat-users.xml"

# Install 'tomcat', 'tomcat-webapps', 'tomcat-admin-webapps'
package { $packages:
	  ensure 				=> installed,
  	before   			=> File["$appdir"],
}

# Create aplication directory
  file { $appdir:
    ensure 				=> directory,
    owner  				=> $user,
    group  				=> $group,
    mode   				=> '0777',
  }

# Configured  /etc/tomcat/tomcat.conf for JAVA_HOME="/usr/java/jdk1.8.0_162/jre"  
  $tomcat_conf_hash = {
    'java_path'   => $java_home,
  }
  file { $tomcat_conf_file:
    owner         => $user,
    group         => $group,
    mode          => '0664',
    content       => epp('tomcat/tomcat.conf.epp', $tomcat_conf_hash),
    notify  => Service['tomcat'],
  }

# Configured  /etc/tomcat/server.xml for docBase and host_name
  $server_conf_hash = {
    'host_name'   => $host_name,
    'appdir'      => $appdir,
  }

  file { $server_conf_file:
    owner         => $user,
    group         => $group,
    mode          => '0664',
    content       => epp('tomcat/server.conf.epp', $server_conf_hash),
    notify  => Service['tomcat'],
  }

  # Configured  /etc/tomcat/tomcat-users.xml for user and password 
  $users_conf_hash = {
    'user_name'   => $user,
    'password'    => $password,
  }

  file { $users_conf_file:
    owner         => $user,
    group         => $group,
    mode          => '0664',
    content       => epp('tomcat/users.conf.epp', $users_conf_hash),
    notify  => Service['tomcat'],
  }

service { 'tomcat':
	enable      => true,
	ensure      => running,
	#hasrestart => true,
	#hasstatus  => true,
	require    => File["$users_conf_file"],
}

}
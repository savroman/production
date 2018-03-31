# Class: tomcat
#
#
class tomcat::configure 
(
  $user             = $tomcat::params::user,
  $password         = $tomcat::params::password, 
  $group            = $tomcat::params::group,
  $java_home        = $tomcat::params::java_home,
  
  # config variables for aplication
  $tomcat_conf_file     = $tomcat::params::tomcat_conf_file,
  $server_conf_file     = $tomcat::params::server_conf_file,
  $users_conf_file      = $tomcat::params::users_conf_file,
  $host_name            = $tomcat::params::host_name,
  $appdir               = $tomcat::params::appdir,
)
{

# Create aplication directory
  file { $appdir:
    ensure        => directory,
    owner         => $user,
    group         => $group,
    mode          => '0777',
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

}
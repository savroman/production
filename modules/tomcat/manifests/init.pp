# Class: tomcat
#
# The tomcat module allows Puppet to install Apache Tomcat7 and  mod_proxy_ajp 
#
#
#
class tomcat 
inherits tomcat::params 
{

  include tomcat::install
  include tomcat::configure
  include tomcat::proxy

  service { 'tomcat':
     enable      => true,
     ensure      => running,
     #hasrestart => true,
     #hasstatus  => true,
     require    => File["$users_conf_file"],
  }
  service { 'httpd':
     enable      => true,
     ensure      => running,
     #hasrestart => true,
     #hasstatus  => true,
    require    => Service['tomcat'],
  }

}
# Class: tomcat
#
#
class tomcat 
inherits tomcat::params 
{

  include tomcat::install
  include tomcat::configure

  service { 'tomcat':
     enable      => true,
     ensure      => running,
     #hasrestart => true,
     #hasstatus  => true,
    # require    => File["$users_conf_file"],
  }
  service { 'httpd':
     enable      => true,
     ensure      => running,
     #hasrestart => true,
     #hasstatus  => true,
    require    => Service['tomcat'],
  }

}
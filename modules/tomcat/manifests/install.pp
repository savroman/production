# Class: tomcat
#
#
class tomcat::install 
(
  $packages         = $tomcat::params::packages,
)
{

# Install 'tomcat', 'tomcat-webapps', 'tomcat-admin-webapps'
package { $packages:
	  ensure 				=> installed,
  	before   			=> Package['httpd'],
}

# install httpd.
    package { 'httpd':
    ensure    => installed,
  }

}
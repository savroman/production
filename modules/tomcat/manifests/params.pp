#
# Class: tomcat::params  related to conf/*.* file of Apache Tomcat and httpd
#

class tomcat::params (
# config variables for aplication
$man_user		      = "$profile::tomcat::man_user",	
$password             = "$profile::tomcat::password", 
$host_name            = "$profile::tomcat::host_name",
$docBase              = "$profile::tomcat::docBase", 
){

# config variables for tomcat
$user 				  = 'tomcat'
$group            	  = 'tomcat'
$java_home            = '/usr/java/jdk1.8.0_162/jre'
$catalina_home        = '/usr/share/tomcat'
$catalina_base        = '/var/lib/tomcat/webapps' 
$confdir              = '/etc/tomcat'
$packages             = ['tomcat', 'tomcat-webapps', 'tomcat-admin-webapps']
$tomcat_conf_file     = "$confdir/tomcat.conf"
$server_conf_file     = "$confdir/server.xml"
$appdir               = "$catalina_base/$docBase"
$users_conf_file      = "$confdir/tomcat-users.xml"

# config variables for mod_proxy
$proxy_conf_file      = "/etc/httpd/conf.d/tomcat.conf"

# config variables for aplication

}
  
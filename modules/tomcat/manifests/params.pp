#
# Class: tomcat::params  related to conf/*.* file of Apache Tomcat and httpd
#

class tomcat::params (
# config global variables for aplication
$man_user		      = "$profile::tomcat::man_user",	
$password             = "$profile::tomcat::password", 
$host_name            = "$profile::tomcat::host_name",
$docBase              = "$profile::tomcat::docBase", 
$catalina_base        = '/var/lib/tomcat/webapps', 
$appdir               = "$catalina_base/$docBase",
$java_home            = "$profile::tomcat::java_home",
$java_OPTS            = "$profile::tomcat::java_OPTS",

){

# config variables for tomcat
$user 				  = 'tomcat'
$group            	  = 'tomcat'
$catalina_home        = '/usr/share/tomcat'
$confdir              = '/etc/tomcat'
$packages             = ['tomcat', 'tomcat-webapps', 'tomcat-admin-webapps']
$tomcat_conf_file     = "$confdir/tomcat.conf"
$server_conf_file     = "$confdir/server.xml"
$users_conf_file      = "$confdir/tomcat-users.xml"

# config variables for mod_proxy
$proxy_conf_file      = "/etc/httpd/conf.d/tomcat.conf"

# config variables for aplication

}
  
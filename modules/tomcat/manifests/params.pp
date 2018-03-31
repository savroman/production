#
# Class: tomcat::params  related to conf/*.* file of Apache Tomcat and httpd
#

class tomcat::params
{

# config variables for tomcat
$user             = 'tomcat'
$password         = 'tomcat' 
$group            = 'tomcat'
$java_home        = '/usr/java/jdk1.8.0_162/jre'
$catalina_home    = '/usr/share/tomcat'
$catalina_base    = '/var/lib/tomcat/webapps' 
$confdir          = '/etc/tomcat'
$packages         = ['tomcat', 'tomcat-webapps', 'tomcat-admin-webapps']

# config variables for mod_proxy
$proxy_conf_file      = "/etc/httpd/conf.d/tomcat.conf"

# config variables for aplication
$host_name            = "bugtrckr.local"
$tomcat_conf_file     = "$confdir/tomcat.conf"
$server_conf_file     = "$confdir/server.xml"
$docBase              = "BugTrckr-0.5.0-SNAPSHOT"
$appdir               = "$catalina_base/$docBase"
$users_conf_file      = "$confdir/tomcat-users.xml"

}
  
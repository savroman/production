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

# config variables for aplication
$tomcat_conf_file     = "$confdir/tomcat.conf"
$server_conf_file     = "$confdir/server.xml"
$host_name            = "bugtrckr.local"
$docBase              = "BugTrckr-0.5.0-SNAPSHOT"
$appdir               = "$catalina_base/$docBase"
$users_conf_file      = "$confdir/tomcat-users.xml"

#  $initd            = '/usr/lib/systemd/system'
#  $shell            = '/bin/bash'
#$key              = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDVCprfpxRFaBoQbSUf30y77OY1YWDzyQE3OM9CA17HUWS3uhLzoIMcZJ0w0EbsM45zX4h0mdya+2fWaoUJW4LZ0bNsfPuNSTYeEbr6y3KIE7+4YqNNXIae0vT7gIFvHM7rcko1mX8IB0bFXutR3rKpQjYxH0/5AEF9x9rPN4r1CjWaWlPr+tY8RWzlqiE0nwAgs293w7O0sY/sApa6j11xDH7d6pcuwswGN80pidQbD4HR9QUnWKTC8bVFrNwo3/RJSYgA9qatK1GNPFTBOm5Y1nVFQhELQvu5e9hCDK5U1Asq8nYTsrIrXCRtuuj/MwUm5C2CN/XXP1FIMj0yrzi1' 
 # $password         = '1b359d8753858b55befa0441067aaed'
}
  
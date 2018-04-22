#Class: profile::jenkins::proxy defines the configuration of mod_proxy_ajp for jenkins
#
#
#
class profile::jenkins::proxy
{
 # config variables for mod_proxy
 $proxy_conf_file = '/etc/httpd/conf.d/tomcat.conf'

# Configure rsyslog
  class {'rsyslog::client':}
  
 rsyslog::config {'httpd':
   log_name          => '/var/log/httpd/*',
   log_tag           => 'httpd_',
   app_name          => 'httpd',
   severity          => 'info',
 }

# Configured  /etc/httpd/conf.d/tomcat.conf for dns_name and AJP13 protocol

 file { $proxy_conf_file:
   ensure            => present,
   owner             => 'root',
   group             => 'root',
   mode              => '0664',
   content           => epp('profile/proxy.conf.epp', {dns_name => $facts['networking']['fqdn']}),
   notify            => Service['httpd'],
 }

# Configure selinux
 exec { 'setsebool':
   command           => 'setsebool -P httpd_can_network_connect=1',
   path              => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
   require           => Package['httpd'],
 }

}

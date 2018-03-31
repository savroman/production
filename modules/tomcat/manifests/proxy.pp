# Class: tomcat::proxy defines the configuration of mod_proxy_ajp
# 
#
#
class tomcat::proxy 
(
  # config variables for mod_proxy
  $host_name            = $tomcat::params::host_name,
#  $proxyfdir            = $tomcat::params::proxyfdir,
  $proxy_conf_file      = $tomcat::params::proxy_conf_file,
)
{

#/usr/sbin/setsebool httpd_can_network_connect true
 exec { 'setsebool':
    command => "setsebool -P httpd_can_network_connect=1",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require => Package['httpd'],
  }

# Configured  /etc/httpd/conf.d/tomcat.conf for host_name and AJP13 protocol
  $proxy_conf_hash = {
    'host_name'   => $host_name,
  }

  file { $proxy_conf_file:
    ensure        => present,
    owner         => 'root',
    group         => 'root',
    mode          => '0664',
    content       => epp('tomcat/proxy.conf.epp', $proxy_conf_hash),
    notify  => Service['httpd'],
  }
}
define rsyslog::client (

  $log_proto = 'udp'
  $log_port   = '514'
  $log_host  = '192.168.56.2'
# the <log_host> value can be defined as an IP address either as a domain name
){
  $dport     = $log_port
  $hosttype  = 'client'

  Exec {
    path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin',
    user => 'root',
  }

  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        'RedHat', 'CentOS': {
          case  versioncmp($::operatingsystemrelease, '7.0') {
            -1: {
            }
            default: { fail("this module supports platform versions from 7.0") }
          }
        }
        default: { fail("unsupported platform ${::operatingsystem}") }
      }
    }
    default: { fail("unsupported platform ${::osfamily}") }
  }

  file { "/etc/rsyslog.conf":
    ensure  => file,
    mode    => '0644',
  	user    => 'root',
    content => template('rsyslog/rsyslog.conf.erb'),
    notify  => Service['rsyslog'],
  }

  service { 'rsyslog':
  	enable      => true,
  	ensure      => running,
  	#hasrestart => true,
  	#hasstatus  => true,
  	#require    => Class["config"],
  }

	
}
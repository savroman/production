## when this resource have been called, 
## it's required to define list of hashes <apps>
## which is reliable for collection of app logs
##  appnamei = {
##    $log_name => 'logname'
##    $app_name => 'appname'
##    $severity => 'severity'
##  }
##  apps = [$appname1, $appname2, ... $appnamen]
##
## where <log_name> - path to application logs (/path/to/logs/*.log in cseof multiple logs)
##       <app_name> - tag name for application

define rsyslog::client (

  $log_proto = 'tcp',
  $log_port  = '601',
  $log_serv  = undef,
  $apps      = undef,
){
# the <log_serv> value can be defined as an IP address either as a domain name
  $db_host   = 'localhost'
  $db_name   = 'syslog'
  $db_user   = 'rsyslog'
  $db_pass   = 'rsyslog'
# variables above are intended for proper work of .conf template
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
              fail('this module supports platform versions from 7.0 up')
            }
            default: { }
          }
        }
        default: { fail("unsupported platform ${::operatingsystem}") }
      }
    }
    default: { fail("unsupported platform ${::osfamily}") }
  }

  file { '/etc/rsyslog.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    content => template('rsyslog/rsyslog.conf.erb'),
    notify  => Service['rsyslog'],
  }

  service { 'rsyslog':
    ensure      => running,
    enable      => true,
    #hasrestart => true,
    #hasstatus  => true,
    #require    => Class["config"],
  }

}

# add to rsyslog.conf 
# local1.* @Apache_IP_address:514

# in Apache config
# vi /etc/httpd/conf/httpd.conf
# add the line below for sending access lods
# CustomLog "| /bin/sh -c '/usr/bin/tee -a /var/log/httpd/httpd-access.log | /usr/bin/logger -thttpd -plocal1.notice'" combined
# add the line below for sending Apache error logs
# ErrorLog "|/bin/sh -c '/usr/bin/tee -a /var/log/httpd/httpd-error.log | /usr/bin/logger -thttpd -plocal1.err'"
# (where local1 ==> facility alias/nickname of apache server)

# httpd
#
# Install Apache Web Server
#
# @example
#   include httpd

class httpd (
  Boolean $welcome_page = false,
  ){
  package {'httpd':
    ensure => installed,
  }

  service {'httpd':
    ensure => running,
    enable => true,
  }

  if $welcome_page {
    warning('Apache will show test page')
  }
  else {
    tidy { '/etc/httpd/conf.d/welcome.conf':
      notify => Service['httpd'],
    }
  }
}

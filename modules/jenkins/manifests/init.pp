# Class: jenkins
# ===========================
#
# Full description of class jenkins here.
#
# @example
#    include jenkins

class jenkins (
  $repo_url = 'https://pkg.jenkins.io/redhat-stable',
  $key_url  = 'https://pkg.jenkins.io/redhat-stable/jenkins.io.key',
  $dport = '8080'
  ){

  yumrepo { 'jenkins':
    ensure   => 'present',
    name     => 'jenkins',
    baseurl  => "${repo_url}",
    gpgcheck => '1',
    before   => Exec[add_gpg_key],
  }

  exec { 'add_gpg_key' :
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command => "rpm --import ${key_url}",
    before   => Package[jenk_inst],
    notify   => Package[jenk_inst],
  }

  package { 'jenk_inst':
    name   => 'jenkins',
    ensure => installed,
    provider => 'yum',
    notify   => Service[jenkins],
  }

  service { 'jenkins':
    ensure     => running,
    name       => 'jenkins',
    hasrestart => true,
    hasstatus  => true,
    enable     => true,
  }

  ::base::firewall {'jenkins':
    dport => "${dport}",
  }
}

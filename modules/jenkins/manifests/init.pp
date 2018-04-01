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
  $dports = ['8080', '9000'],
  ){

  include jenkins::install

  firewall::openport {'jenkins':
    dports => $dports,
  }

  file { '/var/lib/jenkins/jobs/BugTRkckr/config.xml':
    ensure => file,
    mode => '0644',
    content => file('jenkins/config.xml'),
  }
}

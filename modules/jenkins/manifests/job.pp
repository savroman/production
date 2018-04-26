# == Define: jenkins::job
#


define jenkins::job (
  $job_name,
  $user,
  $repoOwner,
  $repository,
  $interval,
  $git_path = 'bin/git',
  ) {
  $url = $jenkins::jenkins_url

  $jobconf_hash = {
    user       => $user,
    repoOwner  => $repoOwner,
    repository => $repository,
    interval   => $interval,
  }

  file { "${jenkins::jenkins_home}/jobs/${job_name}":
    ensure  => directory,
    mode    => '0644',
    owner   => 'tomcat',
    group   => 'tomcat',
  }

  file { "${jenkins::jenkins_home}/jobs/${job_name}/config.xml":
    ensure  => file,
    mode    => '0644',
    owner   => 'tomcat',
    group   => 'tomcat',
    content => epp('jenkins/jobs/simplejob.xml.epp', $jobconf_hash),
  }

  exec { 'restart_tomcat':
    command => 'systemctl restart tomcat',
    path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require => File["${jenkins::jenkins_home}/jobs/${job_name}"],
  }

  #config git
  file { "${jenkins_home_dir}/hudson.plugins.git.gitTool.xml":
    ensure => file,
    mode => '0644',
    content => epp('jenkins/configs/hudson.plugins.git.gitTool.xml.epp', {git_path => $git_path}),
  }
}

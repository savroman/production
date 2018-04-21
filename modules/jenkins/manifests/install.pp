# jenkins::install
# ==========================
#
# Install jenkins and jenkins tools
#
#
# @example
#   include jenkins::install
#
class jenkins::install (
  $jenkins_home_dir   = $jenkins::jenkins_home,
  $java_tool_install  = $jenkins::jdk_tool,
  $java_tool_name     = $jenkins::jdk_tool_name,
  $java_tool_url      = $jenkins::jdk_tool_url,
  $java_tool_subdir   = $jenkins::jdk_tool_subdir,
  $maven_tool_install = $jenkins::mvn_tool,
  $maven_tool_name    = $jenkins::mvn_tool_name,
  $maven_tool_url     = $jenkins::mvn_tool_url,
  $maven_tool_subdir  = $jenkins::mvn_tool_subdir,
  ){

  # install custom jenkins rpm package
  package { 'jenkins_war':
    ensure    => installed,
    name      => 'jenkins2',
    provider  => 'yum',
    subscribe => Service['tomcat'],
  }

  exec { 'wait_for_jenkins_deploy':
    require => Package['jenkins_war'],
    command => 'sleep 30',
    path    => '/usr/bin:/bin',
  }

  ### --- TOOLS INSTALLATION PART ---

  # create folder for groovy scripts
  file { "${jenkins_home_dir}/init.groovy.d":
    ensure  => directory,
    mode    => '0644',
    require => [ Package['jenkins_war'], Exec['wait_for_jenkins_deploy'] ],
  }

  # install jenkins java tool
  if ($java_tool_install) {
    $java_tool_hash = { java_tool_name   => $java_tool_name,
                        java_tool_url    => $java_tool_url,
                        java_tool_subdir => $java_tool_subdir,
                      }

    file { "${jenkins_home_dir}/init.groovy.d/java.groovy":
      ensure  => file,
      mode    => '0744',
      content => epp('jenkins/groovy/java.groovy.epp', $java_tool_hash),
      require => File["${jenkins_home_dir}/init.groovy.d"],
    }
  }

  #install jenkins maven tool
  if ($maven_tool_install) {
    $maven_tool_hash = { maven_tool_name   => $maven_tool_name,
                         maven_tool_url    => $maven_tool_url,
                         maven_tool_subdir => $maven_tool_subdir,
                       }

    file { "${jenkins_home_dir}/init.groovy.d/maven.groovy":
      ensure  => file,
      mode    => '0744',
      content => epp('jenkins/groovy/maven.groovy.epp', $maven_tool_hash),
      require => File["${jenkins_home_dir}/init.groovy.d"],
    }
  }

}

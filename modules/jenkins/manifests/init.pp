# jenkins
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include jenkins
class jenkins (
  $plugins    = ['sonar', 'maven-plugin', 'jquery'],
  $jdk_tool   = 'false',
  $maven_tool = 'false',
  ){
  include jenkins::install

  file { '/usr/share/tomcat/.jenkins/init.groovy.d':
    ensure => directory,
    mode => '0644',
  }

  if ($jdk_tool == 'true') {
    file { '/usr/share/tomcat/.jenkins/init.groovy.d/java.groovy':
      ensure => file,
      mode   => '0744',
      source => 'puppet:///modules/jenkins/groovy/java.groovy',
    }
  }

  if ($maven_tool == 'true') {
    file { '/usr/share/tomcat/.jenkins/init.groovy.d/maven.groovy':
      ensure => file,
      mode   => '0744',
      source => 'puppet:///modules/jenkins/groovy/maven.groovy',
    }
  }


}

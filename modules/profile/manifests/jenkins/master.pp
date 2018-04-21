class profile::jenkins::master {

  # == Class: java8
  #
  class { 'java8':
    local_repo   => 'true',
    local_source => 'http://repo.if083/soft/',
  }

  include httpd
  include firewall


  # Appication variables
    $tomcat_version       = '7.0.76-3.el7_4'
    $dns_name             = "$fqdn"
    $docBase              = 'jenkins'
    $man_user             = 'manager'
    $password             = 'manager'

  # tomcat variables
    $java_home            = '/usr/java/default/'
    $java_heap            = '1024m'

  # firewall variables
    $dports               = ['80', '8080']

  # Configure tomcat
    class { 'tomcat':
      tomcat_version      => $tomcat_version,
      dns_name            => $dns_name,
      docBase             => $docBase,
      man_user            => $man_user,
      password            => $password,
      java_home           => $java_home,
      java_heap           => $java_heap,
    }

  # Configure mod_proxy
    class { 'profile::jenkins::proxy':
    }

  # Configure rsyslog
    class { 'rsyslog::client':
    }

    rsyslog::config { 'tomcat':
      log_name            => '/var/log/tomcat/*',
      log_tag             => 'tomcat_',
      app_name            => 'tomcat',
      severity            => 'info',
    }

  # Configure firewall
    firewall::openport { 'tomcat':
      dports              => $dports,
    }

  # Configure selinux
    exec { 'setenforce':
      command             => 'setenforce 0',
      path                => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      require             => Service['firewalld'],
    }
  # Configure repo
  #  rpmrepo::repocfg {'apps':
  #    reponame => "Our application build repository",
  #    url      => "http://repo.if083",
  #    subpath  => "apps"
  #  }

  class { 'jenkins':
    jenkins_home    => '/usr/share/tomcat/.jenkins',
    jdk_tool        => 'true',
    jdk_tool_name   => 'jdk8',
    jdk_tool_url    => 'http://repo.if083/soft/jdk-8u172-linux-x64.tar.gz',
    jdk_tool_subdir => 'jdk1.8.0_172',
    mvn_tool        => 'true',
    mvn_tool_name   => 'maven3',
    mvn_tool_url    => 'http://repo.if083/soft/apache-maven-3.5.3-bin.tar.gz',
    mvn_tool_subdir => 'apache-maven-3.5.3',
  }


  class { 'jenkins::plugins':
    plugin_repo_url  => 'http://repo.if083/soft/jenkins/plugins',
    plugin_list_file =>
  }
}

# Class: jenkins::plugins
# ===========================
#
# Use it to install jenkins plugin listed in file
#
# @ param plugin_repo_url
#    set the path to reposutory with plugins
#
# @ example
#    class { 'base::firewall':
#      dport => '80',
#    }

class jenkins::plugins (
  $plugin_list_file,
  $plugin_repo_url  = $jenkins::plugin_repo_url,
  ){
  $plugin_dir = "${jenkns::jenkins_home}/plugins"

  file { "${jenkns::jenkins_home}/userContent/plugins.txt":
    ensure => file,
    mode   => '0644',
    source => $plugin_list_file,
  }

  file { "${jenkns::jenkins_home}/userContent/install_plugins.sh":
    ensure  => file,
    mode    => '0744',
    content => epp('jenkins/plugins/install_plugins.epp', {
      plugin_repo_url => $plugin_repo_url,
      plugin_dir      => $plugin_dir}
      ),
  }

  exec { 'plugins_install':
    command => '/usr/share/tomcat/.jenkins/userContent/install_plugins.sh /usr/share/tomcat/.jenkins/userContent/plugins.txt',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require => File['/usr/share/tomcat/.jenkins/userContent/install_plugins.sh'],
  }
}

# maven3
#
# Install Apache maven 3.x.x
#
# @example
#  include maven3
#
#  class { 'maven3':
#    version => '3.5.3',
#  }

class maven3 (
  $maven_version = '3.5.3',
  $load_dir = "/tmp/",
  $maven_url = "http://archive.apache.org/dist/maven/maven-3/",
  $install_path = "/opt/",
  ){

  $archive = "apache-maven-${version}-bin.tar.gz"
  $source = "${maven_url}${version}/binaries/apache-maven-${version}-bin.tar.gz"
  $archive_path = "${load_dir}${archive}"

  if !("jdk1" in $facts['path']) {
    warning('No JDK installed')
  }
  else {

    exec { 'upload_maven_archive':
      command => "wget ${source}",
      path    => '/bin:/sbin:/usr/bin:/usr/sbin:',
      cwd     => "${load_dir}",
      creates => "${archive_path}",
      before  => Exec['maven-untar'],
    }

    exec { 'maven-untar':
      command => "tar xf ${archive_path}",
      cwd     => $install_path,
      creates => "${install_path}apache-maven-${version}",
      path    => '/bin:/sbin:/usr/bin:/usr/sbin:',
    }

    file { '/usr/bin/mvn':
      ensure  => link,
      target  => "/opt/apache-maven-${version}/bin/mvn",
      require => Exec['maven-untar'],
    }
  }
}

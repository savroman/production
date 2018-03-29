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
  $version = '3.5.3',
  ){

  $archive = "apache-maven-${version}-bin.tar.gz"
  $source = "http://archive.apache.org/dist/maven/maven-3/${version}/binaries/apache-maven-${version}-bin.tar.gz"
  $load_dir = "/tmp/"
  $archive_path = "${load_dir}${archive}"

  exec { 'upload_maven_archive':
    command => "wget ${source}",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:',
    cwd     => "${load_dir}",
    creates => "${archive_path}",
    before  => Exec['maven-untar'],
  }

  exec { 'maven-untar':
    command => "tar xf ${archive_path}",
    cwd     => '/opt',
    creates => "/opt/apache-maven-${version}",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:',
  }

  file { '/usr/bin/mvn':
    ensure  => link,
    target  => "/opt/apache-maven-${version}/bin/mvn",
    require => Exec['maven-untar'],
  }
}

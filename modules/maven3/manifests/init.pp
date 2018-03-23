# maven3
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include maven3
class maven3 (
  $version = '3.2.5',
  ){

  $archive = "apache-maven-${version}-bin.tar.gz"
  $source = "http://archive.apache.org/dist/maven/maven-3/${version}/binaries/apache-maven-${version}-bin.tar.gz"
  $load_dir = "/tmp/"
  $archive_path = ${load_dir}${archive}

  exec { 'upload_maven_archive':
    command => "wget ${source}",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    cwd     => "${load_dir}",
    creates => "${archive_path}",
    before  => Exec['maven-untar'],
  }

  exec { 'maven-untar':
    command => "tar xf ${archive_path}",
    cwd     => '/opt',
    creates => "/opt/apache-maven-${version}",
    path    => ['/bin','/usr/bin'],
  }

  file { '/usr/bin/mvn':
    ensure  => link,
    target  => "/opt/apache-maven-${version}/bin/mvn",
    require => Exec['maven-untar'],
  }

  #file { '/usr/local/bin/mvn':
  #  ensure  => absent,
  #}
}

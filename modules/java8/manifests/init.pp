# java8
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include java8
class java8 (
  $java_se = 'jdk',
  $oracle_url = 'http://download.oracle.com/otn-pub/java/jdk/',
  $cookie = '--no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"',
  $version_major = '8u162',
  $version_minor = 'b12',
  $hash = '0da788060d494f5095bf8624735fa2f1',
  $load_dir = "/tmp/",
  ) {

  $rpm = "${java_se}-${version_major}-linux-x64.rpm"
  $source = "${cookie} ${oracle_url}${version_major}-${version_minor}/${hash}/$rpm"
  $java_path = "/usr/java/jdk1.8.0_162"

  # get JDK8 .rpm
  exec { 'upload_rpm':
    command => "sudo wget ${source}",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    cwd     => "${load_dir}",
    creates => "${load_dir}${rpm}",
  }

  # install java
  exec { 'install':
    command => "sudo rpm -ihv ${rpm}",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    onlyif  => "test -e ${load_dir}${rpm}",
  }

  # set PATH veriables
  $app_sh_hash = {
    'java_path' => $java_path,
  }
  file { '/tmp/app.sh':
    ensure  => present,
    mode    => '0775',
    content => epp('java8/app.sh.epp', $app_sh_hash),
  }
  exec { 'set_path':
    command => "sudo mv /tmp/app.sh etc/profile.d/",
    path    => '/bin:/sbin',
    onlyif  => "test -e /tmp/app.sh",
  }
}
#http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm

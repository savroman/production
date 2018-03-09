# java8
#
# This class instal JDK8
#
# @summary A short summary of the purpose of this class
#
# @example
#  include java8 {
#    version_major => '161'
#    hash          => '2f38c3b165be4555a1fa6e98c45e0808'
# }
class java8 (
  $java_se       = 'jdk',
  $oracle_url    = 'http://download.oracle.com/otn-pub/java/jdk/',
  $cookie        = '--no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"',
  $version_major = '162',
  $version_minor = 'b12',
  $hash          = '0da788060d494f5095bf8624735fa2f1',
  $load_dir      = "/tmp/",
  ) {

  $rpm       = "${java_se}-8u${version_major}-linux-x64.rpm"
  $source    = "${cookie} ${oracle_url}8u${version_major}-${version_minor}/${hash}/$rpm"
  $rpm_path  = "${load_dir}${rpm}"
  $java_path = "/usr/java/jdk1.8.0_${version_major}"


  # get JDK8 .rpm
  exec { 'upload_rpm':
    command => "sudo wget ${source}",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    cwd     => "${load_dir}",
    creates => "${rpm_path}",
  }

  # install java
  exec { 'install':
    command => "sudo rpm -ihv ${rpm}",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    onlyif  => "test -e ${rpm_path}",
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
    command => "sudo mv /tmp/app.sh /etc/profile.d/",
    path    => '/bin:/sbin',
    onlyif  => "test -e /tmp/app.sh",
  }
}
#http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm
#http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.rpm

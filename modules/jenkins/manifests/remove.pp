# == Define: jenkins::remove
#
define jenkins::remove (
  $webapps_path,
  ) {
  file { "remove_${title}":
    path   => "${webapps_path}",
    ensure => absent,
  }
}

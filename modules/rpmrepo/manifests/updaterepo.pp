# == Define: rpmrepo::updaterepo
#
# Updates repo
define rpmrepo::updaterepo (
  $repo_dir,
  $user        = $rpmrepo::user,
  $group       = $rpmrepo::group,
  $update_min  = '59',
  $update_hour = 'absent',

  ) {
  cron { 'update_repo':
    command => "createrepo ${repo_dir}",
    user    => $user,
    group   => $group,
    hour    => $update_hour,
    minute  => $update_min,
    require => Package['createrepo'],
  }
}

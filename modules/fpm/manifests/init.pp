# fpm
#
# Add fpm tool for creation custom linux packages
#
#
#
# @example
#   include fpm
class fpm {
  $fpm_needs= ['ruby', 'ruby-devel', 'gcc', 'make', 'rpm-build', 'rubygems',]

  package { $fpm_needs:
    ensure => latest,

  }

  exec { 'gem_update':
    command => 'gem update --system',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require  => Package["${fpm_needs}"],
  }

  package { 'fpm':
    ensure   => installed,
    provider => 'gem',
    require  => Exec[gem_update],
  }
}

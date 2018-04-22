# fpm
#
# Add fpm tool for creation custom linux packages
#
#
#
# @example
#   include fpm
class fpm {
  $fpm_needs= ['ruby-devel', 'gcc', 'make', 'rpm-build', 'rubygems',]

  package { $fpm_needs:
    ensure => latest,
    before => Exec[gem_update],
  }

  exec { 'gem_update':
    command => 'gem update --system',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    before  => Package[fpm],
  }

  package { 'fpm':
    ensure   => installed,
    provider => 'gem',
  }
}

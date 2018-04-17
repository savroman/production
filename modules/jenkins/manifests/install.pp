# jenkins::install
# ==========================
#
# Install jenkins
#
#
# @example
#   include jenkins::install
#
class jenkins::install {

  package { 'jenk_inst':
    name     => 'jenkins2',
    ensure   => installed,
    provider => 'yum',
    notify   => Service[jenkins],
  }

  #jenkins::plugins {'default':
  #  notify   => Service[jenkins],
  #  plugins  => $jenkins::plugins,
  #}

  service { 'jenkins':
    ensure     => running,
    name       => 'jenkins',
    hasrestart => true,
    hasstatus  => true,
    enable     => true,
  }
}

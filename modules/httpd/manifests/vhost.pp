# == Define: vhost
#
#
#
define apache::vhost (
$document_root,
$port,
$server_name   = $facts[fqdn],
$server_alias  = $facts[hostname],
$error_log     = 'undef',
$requests_log  = 'undef',
$user          = 'apache',
$group         = 'apache',
) {

$conf_hash = { document_root => $document_root,
               port          => $port,
               server_name   => $server_name,
               server_alias  => $server_alias,
               error_log     => $error_log,
               requests_log  => $requests_log,
}

  file { "/etc/httpd/conf.d/${title}.conf":
    notify  => Service['httpd'],
    ensure  => file,
    mode    => '0744',
    owner   => $user,
    group   => $group,
    content => epp('apache/vhost.conf.epp', $conf_text),
  }
}

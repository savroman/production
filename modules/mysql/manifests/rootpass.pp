# mysql::rootpass
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::rootpass
class mysql::rootpass (
  $root_pass = 'a8+?treAvpDa',
  $pass_cmd  = "mysqladmin -u root --password=$(grep 'temporary password' /var/log/mysqld.log| awk '{print \$11}') password '${root_pass}'",
)
{

Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
}
exec { 'install_pass':
  command   => $pass_cmd,
  logoutput => true,
  unless    => "mysqladmin -u root -p'${root_pass}' status > /dev/null",
}
}
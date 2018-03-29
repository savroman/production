# Class: name
#
#
class roles::master {
	include profiles::mysqlserver::master
	include profiles::mysqlserver::users
	# resources
}
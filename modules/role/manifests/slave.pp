# Class: name
#
#
class roles::slave {
	include profiles::mysqlserver::replication
	# resources
}
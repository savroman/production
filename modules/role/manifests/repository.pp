# == Class: role::role::repository

class role::repository {
  include profile::basenode
  include profile::rpmrepo
}

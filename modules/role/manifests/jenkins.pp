class role::jenkins::master {
    include profile::base::workspace
    include profile::jenkins::master
    include profile::maven
}

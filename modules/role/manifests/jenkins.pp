class role::jenkins::master {
    include profile::base::workspace
    include profile::java::java8
    include profile::jenkins::master
}

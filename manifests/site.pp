
node default {
  java { 'jdk8' :
    ensure  => 'present',
    version => '8',
    java_se => 'jdk',
  }
}

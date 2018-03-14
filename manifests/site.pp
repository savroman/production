
node agent001 {
  include java8
}
node agent002 {
  class { 'java8': 
    ensure        => 'present',
    java_se       => 'jdk',
    version_major => '161',
    version_minor => 'b12',
    hash      => '0da788060d494f5095bf8624735fa2f1',
  }
}

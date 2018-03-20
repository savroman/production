
node agent001 {
  include java8
  include jenkins
}

node agent002 {
  class { 'java8':
    version_major => '161',
    hash          => '2f38c3b165be4555a1fa6e98c45e0808',
  }
}


node agent001 {
  include java8
}
node agent002 {
  include java8 {
    version_major => '161'
    version_minor => 'b12'
    hash          => '2f38c3b165be4555a1fa6e98c45e0808'
  }
}

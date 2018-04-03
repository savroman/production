class profile::maven (
  $version = "3.3.0",
  $path    = "/usr/",
  ) {
  class maven3 {
    maven_version => $version,
    install_path  => $path,
  }
}

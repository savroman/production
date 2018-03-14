# Class: java::params
class java8::params {

  # calculate in what folder is the binary to use for this architecture
  $arch1 = $::kernel ? {
    'windows' => 'windows',
    'sunos'   => 'solaris',
    'darwin'  => 'macosx',
    default   => 'linux',
  }
  if $arch1 != 'macosx' {
    $arch2 = $::architecture ? {
      'x86_64' => 'x86-64',
      'amd64'  => 'x86-64',
      default  => 'x86-32',
    }
    $arch3 = $::architecture ? {
      'x86_64' => 'x64',
      'amd64'  => 'x64',
      default  => 'i586',
    }
  } else {
    $arch2 = $::architecture ? {
      'x86_64' => 'universal-64',
      default  => 'universal-32',
    }
  }
  $arch = "${arch1}-${arch2}"
  $arch_bit = "${arch1}-${arch3}"

}

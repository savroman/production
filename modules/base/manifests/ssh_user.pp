define base::ssh_user (
    $ssh_user,
    $ssh_password,
    $ssh_group,
)
{
  #$key          = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC+R3QXANAoW/mu6yQufC2ZO/llJp7nV1Dk4hi0v2KkyRAk3fQKPgk8FuvuNLxA0IbEMebnQPeEdu3IybJZ9flc8C7DPvB6pP8JHGpS9dZnUjjtVR7ebBJ2dEZcSbJYeP4xrXmu8nCb5EFrvceLRZcBtSwdhtNRBflya6NEFEGee5cVCSmDYfDlapPQOCqIdvTWqHxghQojA5qyQ4psfRfX0+H/wEHGs1ztw4rp+vVlAVLLPsNeOFyq+x6YKNcHloZDpawiT6Qm4DgC3KeUKwfUFLl4GaDZhcu/HFmzmGQqG/YzoUct7zyudcr9w9YHpkV8QgM53wP1alFw3G4EJa7L'
  #$group        = 'wheel',
  $shell        = "/bin/bash"
  $home         = "/home/${ssh_user}"
  $ssh          = "$home/.ssh"
  $key          = "$ssh/authorized_keys"



  user { "$ssh_user":
    ensure      => present,
    name        => $ssh_user,
    password    => $ssh_password,
    groups      => $ssh_group,
    shell       => $shell,
    home        => $home,
    #uid         => '501',
    #gid         => '20',
    #managehome  => true,
  }

  file { "$home":
    ensure      => directory,
    owner       => $ssh_user,
    group       => $ssh_group,
    mode        => '0755',
  }

  file { "$ssh":
    ensure      => directory,
    owner       => $ssh_user,
    group       => $ssh_group,
    mode        => '0700',
    require     => File[ "$home" ],
  }
 
  # Configured  /etc/tomcat/server.xml for docBase and host_name
  $key_hash     = {
    'host_name' => "${ssh_user}@$fqdn",
  }

  file { "$key":
    owner       => $user,
    group       => $group,
    mode        => '0600',
    content     => epp('base/key.epp', $key_hash),
    require     => File[ "$ssh" ], 
  }
  
}
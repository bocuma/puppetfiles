define bocuma::user ($user = 'app',$shell = '/bin/bash', $state = 'present', $ssh_key = undef, $ssh_key_type = undef, $groups = []) {
  user { $user:
    ensure => $state,
    managehome => true,
    shell => $shell,
    groups => $groups
  }
  file {"/home/$user":
    ensure => directory,
    mode => 750,
    require => User["$user"]
  
  }
 
  if $ssh_key {
     ssh_authorized_key {"$user-ssh-key":
       ensure => $state,
       key => $ssh_key,
       type => $ssh_key_type,
       user => $user
     }
  }

}


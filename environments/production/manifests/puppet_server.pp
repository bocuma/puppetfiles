class bocuma::puppet_server ( $ruby = 'ruby-2.0.0-p451' ) {
  $user = 'app'

  include git
  include ssh_keys
  include rvm

  bocuma::user {"${user}":
    user => $user,
  } 
  ssh_keys::user{"$user":
    manage_ssh_dir => true,
  }  
  ssh_keys::authorized_key{"$user":
    key_line => 'ssh-dss AAAAB3NzaC1kc3MAAACBAOJwpIST6mAJxLcVYClwPc6VPGHc7k9cMweGqxQ24t56qK518AZujdQvc1in2sRqGeY0xSDuSk/LQMq8Scirk815zVfn1baFptDptp/XC3vuY7QB9h4BUByAAZb8qCpqdsWyWL6F+Oq0wZTDV26BHpe/+gkkWnzDsQkaBisuI0RhAAAAFQCTs3/sVxDGhuwJTbrPeU31ZdocSQAAAIB49hjyhqRR4TOqqbb5EgykiG/R5Rmpq/WYRIMHJZDZadSDbsUXeO6T+s7WSAbskEcO9QqnUVnM4qpyZZ1GQEgsIlpG/M5uUiKOOAwQ93OiszzQVywLyl85sM6hvrMu6ck5u/oythTgjDkY5d5Gk/QGQm/6irZdkDbX/WwEXqtE0wAAAIEA28x0EL25SuokwO4TAn9tq04pcxiWo2xLDcWLCiZprkz7OOgbOp/ftTsCdoUOjLPnSSRw3Wye0xXb2upz7VvVYrQk16S4ejwBbd6zOKMJBsMXrUOnlRZiAV4RPNuxdz9Etr82czTKQlBJQtkrYuHEuJqfdEByYf+98XrnVk5+Hoc= mr_x_indeed@moosel',
    user => 'app'
  } 
  rvm::system_user { "${user}": ;  }
  rvm_system_ruby {
    $ruby:
      ensure      => 'present',
      default_use => false;
  }

  bocuma::directory {"puppet-config-directory":
    dir => "/var/puppet",
    owner => $user,
  } 
  file { '/etc/puppet':
    ensure => 'link',
    target => '/var/puppet/current',
  }

}

define bocuma::god ($state = 'present', $ruby = 'ruby-2.0.0-p451', $version = 'latest', $gemset = 'god-gemset' ) {

  if !defined(Class['rvm']) {
   include rvm
  } 

  file { "god-dir":
      path => "/etc/god",
      ensure => "directory"
  }

  file {"god-config": 
    path => "/etc/god/god.conf",
    require => File["god-dir"],
    content => "God.load \"/etc/god/conf.d/*.god\""
  }
  if (!defined(Rvm_system_ruby[$ruby])) {
    rvm_system_ruby {
      $ruby:
        ensure      => $state,
        default_use => false,
        require => Class['rvm']
    }
  }

  rvm_gemset {
    "$ruby@$gemset":
      ensure  => $state,
      require => Rvm_system_ruby[$ruby];
  }
  rvm_gem {
    "$ruby@$gemset/god":
      ensure  => $version,
      require => Rvm_gemset["$ruby@$gemset"];
  }
  rvm_wrapper {
    'god':
      target_ruby => $ruby,
      prefix      => 'bootup',
      ensure      => $state,
      require => Rvm_gemset["$ruby@$gemset"];
  }
}


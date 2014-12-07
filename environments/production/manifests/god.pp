define bocuma::god ($state = 'present', $ruby = 'ruby-2.0.0-p451', $version = 'latest', $gemset = 'god-gemset' ) {
  if !defined(Class['rvm']) {
   include rvm
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

bocuma::god {'test':}


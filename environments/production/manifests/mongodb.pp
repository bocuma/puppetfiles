class bocuma::mongodb {
  class {'::mongodb::globals':
  manage_package_repo => true,
  }->
  class { '::mongodb::server': 
    bind_ip => ["0.0.0.0"]
  } ->
  class {'::mongodb::client':}

  #package {"monit":
  #  ensure => present
  #}
  #service {"monit":
  #  ensure => running
  #}

  #monit::monitor {"mongod":
  #  pidfile => '/var/run/mongodb/mongod.pid'
  #}
}

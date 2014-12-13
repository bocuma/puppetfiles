class bocuma::mongodb ($replset = "prod0",  $logpath = "/var/log/mongodb/mongod.log", $dbpath = "/srv/mongod" ) {
  class {'::mongodb::globals':
    manage_package_repo => true,
  }->
  class { '::mongodb::server': 
    bind_ip => ["0.0.0.0"],
    replset => $replset,
    dbpath => $dbpath,
    logpath => $logpath
  } ->
  bocuma::logrotate { "mongod":
    name => "mongod",
    path => $logpath
  }
  god::process { "mongod":
    name => "mongod",
    start_command => "mongod -f $config",
    stop_command => "/etc/init.d/mongod stop",
  }
  class {'::mongodb::client':}

}

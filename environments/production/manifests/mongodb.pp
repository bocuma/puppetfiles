class bocuma::mongodb ($replset = "prod0", $pidfilepath = "/var/run/mongod.pid", $logpath = "/var/log/mongod.log", $dbpath = "/srv/mongod" ) {
  class {'::mongodb::globals':
    manage_package_repo => true,
  }->
  class { '::mongodb::server': 
    bind_ip => ["0.0.0.0"],
    replset => $replset,
    pidfilepath => $pidfilepath,
    dbpath => $dbpath,
    logpath => $logpath
  } ->
  bocuma::logrotate { "mongod":
    name => "mongod",
    path => $logpath
  }
  god::process { "mongod":
    name => "mongod",
    start_command => "/etc/init.d/mongod start",
    stop_command => "/etc/init.d/mongod stop",
    restart_command => "/etc/init.d/mongod restart",
    pidfile => $pidfilepath
  }
  class {'::mongodb::client':}

}

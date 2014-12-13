class bocuma::web_server {
  class { 'nginx': 
  }
  god::process { "nginx":
    name => "nginx",
    start_command => "/etc/init.d/nginx start",
    restart_command => "/etc/init.d/nginx restart",
    stop_command => "/etc/init.d/nginx start",
  }
}



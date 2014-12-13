class bocuma::web_server {
  class { 'nginx': 
  }
  god::process { "nginx":
    name => "nginx",
    start_command => "nginx -c /etc/nginx/nginx.conf",
    stop_command => "/etc/init.d/nginx start",
    pidfile => "/var/run/nginx.pid"
  }
}



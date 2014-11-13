class bocuma::web_server {
  class { 'nginx': 
  }
  #package {"monit":
  #  ensure => present
  #}
  #service {"monit":
  #  ensure => running
  #}
  #monit::monitor {"nginx":
  #  pidfile => '/var/run/nginx.pid'
  #}
}



class bocuma::redis_server {
  $port = 6379
  include redis
  god::process { "redis_$port":
    name => "redis_$port",
    start_command => "/etc/init.d/redis_$port start",
    stop_command => "/etc/init.d/redis_$port stop",
    restart_command => "/etc/init.d/redis_$port restart",
    pidfile => "/var/run/redis_$port.pid"
  }

}

define bocuma::rails_app ($app_name,$user = 'app', $state = 'present',$server_name, $rvm = 'ruby-2.0.0-p451' ) {
  if ! defined(Rvm_system_ruby["${rvm}"]) {
    rvm_system_ruby {
      "${rvm}":
      ensure => 'present',
      default_use => true;
    }

  }

  $nginx_user = $nginx::params::nx_daemon_user
  bocuma::directory { "${app_name}-${user}-home-directory":
   dir => "/home/${user}/webapps/${app_name}",
   owner => "${user}",
   mode => 750,
   group => $nginx_user
  }

  if ! defined(File["/var/log/webapps"]) {
    file {"/var/log/webapps":
     ensure => "directory",
     owner => $nginx_user,
     group => $nginx_user,
     mode => 770
     }
    }

  file {"/var/log/webapps/${app_name}":
   ensure => "directory",
   owner => $nginx_user,
   group => $nginx_user,
   mode => 770
  }

  bocuma::logrotate { "/var/log/webapps/${app_name}":
    name => "${app_name}",
    path => "/var/log/webapps/${app_name}"
  }

  if ! defined(File["/var/run/webapps"]) {
    file {"/var/run/webapps":
     ensure => "directory",
     owner => $nginx_user,
     group => $nginx_user,
     mode => 770
    }
  }

  file {"/var/run/webapps/${app_name}":
   ensure => "directory",
   owner => $nginx_user,
   group => $nginx_user,
   mode => 770
  }


  nginx::resource::vhost {"${app_name}":
    ensure => $state,
    proxy => "http://${app_name}",
    server_name => $server_name 
  }

  nginx::resource::location {"${app_name}-websocket":
    ensure => $state,
    proxy => "http://localhost:3001",
    raw_append => [
      "proxy_http_version 1.1;",
      'proxy_set_header Upgrade $http_upgrade;',
      'proxy_set_header Connection "upgrade";'
    ],
    location => "/websocket",
    vhost => "${app_name}"
  }

  nginx::resource::location {"${app_name}-assets":
    ensure => $state,
    www_root => "/home/${user}/webapps/${app_name}/current/public",
    raw_append => [
      "expires 1y;",
      "add_header Cache-Control public;",
      "add_header Last-Modified \"\";",
      "add_header Etag \"\";",
      "break;"
    ],
    location => "~* ^/assets/",
    vhost => "${app_name}"
  }


  nginx::resource::upstream {"${app_name}":
    ensure => $state,
    members => ["unix:///var/run/webapps/${app_name}/server.sock"]
  }
}

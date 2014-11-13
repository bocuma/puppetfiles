define bocuma::jruby_server {
  class { 'java': } ->
  class { 'ant': } ->
  class { 'maven::maven': } 
}

define bocuma::logrotate ($name, $path, $rotate = 20,$size = '100k') {
  logrotate::rule { $name: 
    path => $path,
    rotate => $rotate,
    size => $size
  }
}

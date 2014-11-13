define bocuma::directory ($dir,$owner,$mode = 750, $group = $owner) {
  file { $dir:
    ensure => "directory",
    owner => $owner,
    group => $owner,
    mode => $mode
  }
}



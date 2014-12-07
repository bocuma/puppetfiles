class bocuma::nokogiri {
  case $operatingsystem {
    centos: {$dev = "devel"}
    redhat: {$dev = "devel"}
    default: { $dev = "dev"}
  }
  package {"ruby-$dev":
   ensure => "installed"
  }
  package {"libxml2":
   ensure => "installed"
  }
  package {"libxml2-$dev":
   ensure => "installed"
  }
  package {"libxslt":
   ensure => "installed"
  }

  package {"libxslt-$dev":
   ensure => "installed"
  }
}

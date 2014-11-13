class bocuma::nokogiri {
  package {"ruby-devel":
   ensure => "installed"
  }
  package {"libxml2":
   ensure => "installed"
  }
  package {"libxml2-devel":
   ensure => "installed"
  }

  package {"libxslt":
   ensure => "installed"
  }

  package {"libxslt-devel":
   ensure => "installed"
  }

}

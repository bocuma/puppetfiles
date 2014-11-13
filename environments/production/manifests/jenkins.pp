class bocuma::jenkins {
   yumrepo {"jenkins_yum_repo":
     baseurl => "http://pkg.jenkins-ci.org/redhat",
     enabled => 1,
     gpgkey => "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"

    } 
  include jenkins
  package {"libyaml-devel":
    ensure => "present"
  }
  user {"jenkins":
    shell => "/bin/bash",
    managehome => true,
    ensure => "present"
  } ->
  single_user_rvm::install {'jenkins':
    home => "/var/lib/jenkins"
  } 
  file {"rvmrc-jenkis":
    path => "/var/lib/jenkins/.rvmrc",
    owner => "jenkins",
    content => "rvm_install_on_use_flag=1\nrvm_project_rvmrc=1\nrvm_gemset_create_on_use_flag=1"
  }
}

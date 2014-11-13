# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'puppet_config'
set :repo_url, 'git@scotlinetours.co.uk:/home/git/repositories/puppet.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/puppet'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, { LIBRARIAN_PUPPET_PATH: "environments/production/modules" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :server_root, "/usr/share/puppet/rack/puppetmasterd/"
set :rvm1_ruby_version, "ruby-2.0.0-p481"
set :bundle_bins, fetch(:bundle_bins, []).push("librarian-puppet")

before 'deploy', 'rvm1:install:ruby'  
namespace :deploy do

  desc 'Restart application'
  task :install_library do
    on roles(:app)  do
      within release_path do
        execute :bundle, "exec librarian-puppet install"
      end
    end
  end

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "touch #{fetch(:server_root)}/tmp/restart.txt"
    end
  end

  #after :publishing, :install_library
  #after :install_library, :restart
end

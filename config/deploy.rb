#require 'rvm/capistrano'
#require 'bundler/setup'
#require 'bundler/capistrano'
# require 'capistrano3/unicorn'
# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'ApiUzz'
set :repo_url, 'git@github.com:oozzal/apiuzz.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :user, 'vagrant'
set :deploy_to, '/home/vagrant/apiuzz'

set :use_sudo, false

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
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :default_env, { :staging }

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do

  desc 'Restart application'
  task :restart do
#    invoke "unicorn:restart"
    invoke "unicorn:stop"
    invoke "unicorn:start"
  end

  task :gems_install do
    on roles(:app), in: :sequence, wait: 3 do
      execute "cd #{release_path} && bundle install"
    end
  end
end

namespace :unicorn do
  desc "Stop the Unicorn Server"
  task :stop do
    on roles(:app) do
      execute "cat /tmp/pids/unicorn.pid | xargs kill -QUIT" if File.exists?("/tmp/pids/unicorn.pid")
    et
    n
  end

  desc "Start the Unicorn Server"
  task :start do
    on roles(:app) do
      execute "cd #{release_path} && bundle exec unicorn -c config/unicorn.rb"
    end
  end
end

after "deploy:publishing", "deploy:gems_install"
after "deploy:gems_install", "deploy:restart"


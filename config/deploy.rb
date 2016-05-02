set :application, 'cherashev'
set :app_version, '0.2'

set :scm, :git
set :pty, true
set :repo_url, 'git@github.com:MrCherry/cherashev.git'
set :keep_releases, 5

set :ssh_options, {forward_agent: true, keys: %w('~/.ssh/cherashev_rsa.pub')}

# set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.3.1@cherashev'      # Defaults to: 'default'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, %w{config/database.yml config/redis.yml config/secrets.yml})
set :linked_dirs, %w{log tmp/cache tmp/pids tmp/sockets public/uploads}

SSHKit.config.command_map[:rake]  = 'bundle exec rake'
SSHKit.config.command_map[:rails] = 'bundle exec rails'

namespace :deploy do
  task :start do
    on release_roles :all do
      execute "sudo /usr/bin/sv start #{fetch(:application)}-puma"
    end
  end

  task :stop do
    on release_roles :all do
      execute "sudo /usr/bin/sv stop #{fetch(:application)}-puma"
    end
  end

  task :restart do
    on release_roles :all do
      execute "sudo /usr/bin/sv restart #{fetch(:application)}-puma"
    end
  end

  after :finishing, 'deploy:cleanup'
  after :publishing, :restart
end

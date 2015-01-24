# lock '3.3.5'

set :application, 'cherashev'
set :app_version, '0.1'

set :repo_url, 'git@github.com:MrCherry/cherashev.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/cherashev/projects/#{fetch(:application)}_#{fetch(:app_version).gsub(".", "_")}/"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/cache tmp/pids tmp/sockets}

set :ssh_options, {
    forward_agent: true,
    keys: %w('~/.ssh/cherashev_rsa.pub')
}
SSHKit.config.command_map[:rake]  = 'bundle exec rake'
SSHKit.config.command_map[:rails] = 'bundle exec rails'

# Default value for default_env is {}
# set :rvm_type,         :user
set :rvm_ruby_version, 'ruby-2.1.5@cherashev'

# TODO:
# http://www.talkingquickly.co.uk/2014/01/deploying-rails-apps-to-a-vps-with-capistrano-v3/
# https://semaphoreapp.com/blog/2013/11/26/capistrano-3-upgrade-guide.html

# Unicorn
set :unicorn_pid,         File.join(shared_path, 'tmp', 'pids', 'unicorn.pid')
set :unicorn_config_path, File.join(current_path, 'config', 'unicorn.rb')
# after 'deploy:start',   'unicorn:start'
# after 'deploy:restart', 'unicorn:restart'
# after 'deploy:stop',    'unicorn:stop'

namespace :deploy do

  after 'deploy:publishing', 'deploy:restart'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :finishing, 'deploy:cleanup'

  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     # Your restart mechanism here, for example:
  #     # execute :touch, release_path.join('tmp/restart.txt')
  #   end
  # end
  #
  # after :publishing, :restart
  #
  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

  # desc 'Restart application'
  # after :publishing, :build_missing_paperclip_styles do
  #   on roles(:app) do
  #     within release_path do
  #       with rails_env: fetch(:rails_env) do
  #         execute :rake, 'paperclip:refresh:missing_styles'
  #       end
  #     end
  #   end
  # end

  # TODO: create nginx symlink and reload nginx
end

rails_env = ENV['RAILS_ENV'] || 'production'
app_dir = '/home/deployer/cherashev'
tmp_dir = "#{app_dir}/tmp"

environment rails_env
directory app_dir

threads 0,16
workers 8

preload_app!

pidfile "#{tmp_dir}/pids/puma.#{rails_env}.pid"
state_path "#{tmp_dir}/pids/puma.#{rails_env}.state"
 
bind "unix://#{tmp_dir}/sockets/puma.#{rails_env}.sock"

prune_bundler

restart_command 'bundle exec bin/puma'

# Logging
stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

# activate_control_app "unix://#{tmp_dir}/sockets/pumactl.#{rails_env}.sock"

on_worker_boot do
  require 'active_record'
  config_path = File.expand_path('../../database.yml', __FILE__)
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || YAML.load_file(config_path)[ENV['RAILS_ENV']])
end


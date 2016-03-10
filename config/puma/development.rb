rails_env = ENV['RAILS_ENV'] || 'development'
vagrant = Dir.exists?('/cherashev')

app_dir = (vagrant ? '/cherashev' : Dir.pwd)
tmp_dir = "#{app_dir}/tmp"

environment rails_env
directory app_dir

threads 0, 16
workers 2

preload_app!

pidfile "#{tmp_dir}/pids/puma.#{rails_env}.pid"
state_path "#{tmp_dir}/pids/puma.#{rails_env}.state"

bind "unix://#{tmp_dir}/sockets/puma.#{rails_env}.sock"

prune_bundler

restart_command 'bundle exec bin/puma'

# Logging
if vagrant
  stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true
end

# activate_control_app "unix://#{tmp_dir}/sockets/pumactl.#{rails_env}.sock"

on_worker_boot do
  # Don't bother having the master process hang onto older connections.
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

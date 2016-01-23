environment ENV['RAILS_ENV']
directory '/home/deployer/cherashev'

threads 0,16
workers 8

preload_app!

pidfile '/home/deployer/cherashev/tmp/pids/puma.production.pid'

bind 'unix:///full/path/to/your/project/tmp/puma.sock'

prune_bundler

restart_command 'bundle exec bin/puma'

on_worker_boot do
  require 'active_record'
  config_path = File.expand_path('../config/database.yml', __FILE__)
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || YAML.load_file(config_path)[ENV['RAILS_ENV']])
end


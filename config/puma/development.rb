environment ENV['RAILS_ENV']
# directory '/cherashev'

threads 0,16
workers 2

# preload_app!

pidfile File.expand_path('../tmp/pids/puma.development.pid', __FILE__)

port '3000'

prune_bundler

restart_command 'bundle exec bin/puma'

on_worker_boot do
  require 'active_record'
  config_path = File.expand_path('../config/database.yml', __FILE__)
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || YAML.load_file(config_path)[ENV['RAILS_ENV']])
end

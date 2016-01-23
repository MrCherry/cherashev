working_directory '/cherashev'

pid '/cherashev/tmp/pids/unicorn.development.pid'

stderr_path '/cherashev/log/unicorn.err.log'
stdout_path '/cherashev/log/unicorn.log'

listen '/cherashev/tmp/sockets/unicorn.development.sock'

worker_processes 2

timeout 30

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end

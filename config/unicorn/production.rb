working_directory '/home/deployer/cherashev/current'

pid '/home/deployer/cherashev/shared/tmp/pids/unicorn.production.pid'

stderr_path '/home/deployer/cherashev/shared/log/unicorn.err.log'
stdout_path '/home/deployer/cherashev/shared/log/unicorn.log'

listen '/home/deployer/cherashev/shared/tmp/sockets/unicorn.production.sock'

worker_processes 8

timeout 30

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end

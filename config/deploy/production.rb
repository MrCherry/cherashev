set :stage, :production
set :branch, 'master'
set :rails_env, 'production'
set :username, 'deployer'
set :deploy_to, "/home/#{fetch(:username)}/#{fetch(:application)}/"
server 'cherashev.com', user: fetch(:username), roles: %w(web app db)

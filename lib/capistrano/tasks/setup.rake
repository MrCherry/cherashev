namespace :setup do

  task :default do
    invoke 'setup:upload_yml'
    # invoke 'setup:symlink_config'
    # invoke 'setup:nginx_reload'
  end

  desc 'Upload database.yml and secrets.yml files.'
  task :upload_yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
      upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
    end
  end

  # desc 'Создание симлинка в /etc/nginx/conf.d на nginx.conf приложения'
  # task :append_config do
  #   on roles :all do
  #     sudo :ln, "-fs #{shared_path}/config/nginx.conf /etc/nginx/conf.d/#{fetch(:application)}.conf"
  #   end
  # end

  # desc "Symlinks config files for Nginx and Unicorn."
  # task :symlink_config do
  #   on roles(:web) do
  #     # execute "rm -f /etc/nginx/sites-enabled/default"
  #     # execute "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
  #     execute "ln -nfs #{current_path}/config/#{fetch(:application)}_#{fetch(:app_version).gsub(".", "_")} /etc/nginx/sites-enabled/#{fetch(:application)}_#{fetch(:app_version).gsub(".", "_")}"
  #   end
  # end

  # desc 'Reload Nginx'
  # task :nginx_reload do
  #   on roles(:web) do
  #     execute '/etc/init.d/nginx reload'
  #   end
  # end
end

task :setup => 'setup:default'

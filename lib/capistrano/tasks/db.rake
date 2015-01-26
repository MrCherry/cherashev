namespace :db do
  desc 'rake db:migrate, rake db:seed'
  task :default do
    invoke 'db:migrate'
    invoke 'db:seed'
  end

  desc 'cap deploy:update, rake db:migrate, rake db:seed'
  task :update do
    invoke 'deploy'
    invoke 'db:migrate'
    invoke 'db:seed'
  end

  desc 'rake db:migrate'
  task(:migrate) { invoke 'deploy:migrate' }

  desc 'rake db:rollback'
  task(:rollback) do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:rollback'
        end
      end
    end
  end

  desc 'rake db:seed'
  task(:seed) do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end

task :db => 'db:default'

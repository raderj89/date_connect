# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'your_app_name'
set :repo_url, 'your_git_repo'
set :branch, 'master'

set :deploy_to, '/home/your_app_directory/public_html/your_app_name/'

SSHKit.config.command_map[:rake]  = "bundle exec rake" 
SSHKit.config.command_map[:rails] = "bundle exec rails"
SSHKit.config.command_map[:rake] = "bundle exec rake jobs:work RAILS_ENV=production"

set :delayed_job_command, "bin/delayed_job"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
      on roles(:web), in: :groups, limit: 3, wait: 10 do
        # Here we can do anything such as:
        # within release_path do
        #   execute :rake, 'cache:clear'
        # end
      end
  end
end

namespace :delayed_job do

  def args
    fetch(:delayed_job_args, "")
  end

  def delayed_job_roles
    fetch(:delayed_job_server_role, :app)
  end

  desc 'Stop the delayed_job process'
  task :stop do
    on roles(delayed_job_roles) do
      within release_path do    
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', :stop
        end
      end
    end
  end

  desc 'Start the delayed_job process'
  task :start do
    on roles(delayed_job_roles) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', args, :start
        end
      end
    end
  end

  desc 'Restart the delayed_job process'
  task :restart do
    on roles(delayed_job_roles) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, :'bin/delayed_job', args, :restart
        end
      end
    end
  end

end

after 'deploy:publishing', 'deploy:restart'                                     
namespace :deploy do                                                            
  task :restart do                                                                                                               
    invoke 'delayed_job:restart'                                                
  end                                                                           
end

set :linked_dirs, %w{public/system}

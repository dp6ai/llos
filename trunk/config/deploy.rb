
default_run_options[:pty] = true 

set :application, "llos"
set :repository,  "https://llos.svn.beanstalkapp.com/llos/trunk"
set :scm_username , "lloydloom"
set :scm_password, "L10yd100m"
# set :scm_command, "/usr/bin/svn"
set :user, "deployment"
set :password, "d3pl0ym3nt7584"

set :scm, :subversion
set :keep_releases, 3      unless exists?(:keep_releases)

role :web, "www.lloydloom.com"                          # Your HTTP server, Apache/etc
role :app, "www.lloydloom.com"                          # This may be the same as your `Web` server
role :db,  "www.lloydloom.com", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "symlink images, auto for prod, forced for staging"
  task :symlinks, :roles => :app do
    run "ln -nfs #{shared_path}/system #{current_path}/public/system"
  end

end


task :production do
  set :deploy_to, "~/#{application}"
  puts "\n\e[0;31m   ######################################################################"
  puts "   #\n   #       Are you REALLY sure you want to deploy to PRODUCTION?"
  puts "   #\n   #               Enter y/N + enter to continue\n   #"
  puts "   ######################################################################\e[0m\n"
  proceed = STDIN.gets[0..0] rescue nil
  exit unless proceed == 'y' || proceed == 'Y'

end

task :staging do
  set :deploy_to, "~/#{application}/staging"
end



after :deploy, "deploy:symlinks"
after :deploy, "deploy:restart"
after :deploy, "deploy:cleanup"
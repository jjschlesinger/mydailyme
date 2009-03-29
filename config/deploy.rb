set :application, "beta.mydailyme"
set :repository,  "git@github.com:jjschlesinger/mydailyme.git"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :copy
set :scm, :git
set :host, "slice1.mydailyme.net"
set :port, 22000
ssh_options[:paranoid] = false
set :use_sudo, false
#set :user, "www-data"


role :app, host
role :web, host
role :db,  host, :primary => true

task :after_symlink, :roles => :app do
	run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
	#run "cp /var/www/mydailyme/public/me_images/* #{release_path}/public/me_images"
	run "rm -rf #{release_path}/public/me_images"
#	run "ln -nfs #{shared_path}/me_images #{release_path}/public/"
	run "ln -nfs #{shared_path}/me_images/ #{release_path}/public/me_images"
	run "mv #{release_path}/app/controllers/application_controller.rb #{release_path}/app/controllers/application.rb"
end

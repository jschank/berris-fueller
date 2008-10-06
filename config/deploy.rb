# ===============
# = Application =
# ===============
set :application, "berris-fueller"
set :deploy_to, "/Volumes/Phoenix/RailsApps/#{application}"

# ============
# = Settings =
# ============
#default_run_options[:pty] = true
#set :use_sudo, true
set :use_sudo, false

# ===========
# = Servers =
# ===========
set :user, "deploy"
set :domain, "cooper.local"
#server domain, :app, :web
role :app, domain
role :web, domain
role :db,  domain, :primary => true

# =======
# = git =
# =======
set :scm, :git
set :scm_command, "/usr/local/git/bin/git"
set :repository,  "git@cooper.local:berris-fueller.git"
set :scm_username, user
set :runner, user
set :branch, "master"

# =========
# = Rails =
# =========
set :rails_env, 'production'

# =============
# = Passenger =
# =============
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

# ===========
# = Mongrel =
# ===========
# set :mongrel_servers, 3
# set :mongrel_port, 8000

# Or, at the top of this recipe:
#   require 'mongrel_cluster/recipes'

# namespace :deploy do
#   desc "Restarting mod_rails with restart.txt"
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "touch #{current_path}/tmp/restart.txt"
#   end
#  
#   [:start, :stop].each do |t|
#     desc "#{t} task is a no-op with mod_rails"
#     task t, :roles => :app do ; end
#   end
# end


set :deploy_to, "/home/jerry/apps/#{application}"
set :user, "jerry"
server "218.6.165.20", :app, :web, :db, :primary => true
set :deploy_via, :copy
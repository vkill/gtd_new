require "capsum/typical3"

set :application, "gtd_new"
set :repository, "git://github.com/vkill/gtd_new.git"
set :branch, "master"

set :shared, %w{
  config/database.yml
}
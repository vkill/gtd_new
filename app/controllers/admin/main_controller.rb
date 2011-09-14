class Admin::MainController < Admin::BaseController

  main_nav_highlight :main

  def index
    @sec_nav = :dashboard
  end

end


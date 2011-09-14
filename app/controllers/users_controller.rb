class UsersController < Devise::RegistrationsController

  layout 'admin', :only => 'edit'
  before_filter :authenticate_user!
  main_nav_highlight :main
  sec_nav_highlight :profile


end


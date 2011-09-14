class PasswordsController < Devise::RegistrationsController

  layout 'admin'
  before_filter :authenticate_user!
  main_nav_highlight :main
  sec_nav_highlight :password

end


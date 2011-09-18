class UsersController < Devise::RegistrationsController

  layout :set_layout
  before_filter :authenticate_user!
  main_nav_highlight :main
  sec_nav_highlight :profile

  private
    def set_layout
      case params[:action]
      when 'edit', 'update'
        'admin'
      when 'new', 'create'
        'application'
      else
        false
      end
    end
end


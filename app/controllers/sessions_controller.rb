class SessionsController < Devise::SessionsController

  layout 'application'
  main_nav_highlight :main
  sec_nav_highlight :logout

  private
    def after_sign_in_path_for(resource)
      if resource.roles_mask?
        admin_root_path
      else
        root_path
      end
    end
end


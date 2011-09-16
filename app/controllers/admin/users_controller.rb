class Admin::UsersController < Admin::BaseController

  load_and_authorize_resource

  main_nav_highlight :basic
  sec_nav_highlight :users

  protected
    def end_of_association_chain
      if current_user.has_role? 'admin'
        resource_class
      elsif current_user.has_role? 'chief'
        current_user.department.users
      end
    end
end


class Admin::BusinessesController < Admin::BaseController

  load_and_authorize_resource

  main_nav_highlight :issues
  sec_nav_highlight :businesses

  protected
    def end_of_association_chain
      if current_user.has_role? 'admin'
        end_of_association_chain
      elsif current_user.has_role? 'chief'
        current_user.department.businesses
      elsif current_user.has_role? 'staff'
        current_user.accept_businesses
      end
    end
end


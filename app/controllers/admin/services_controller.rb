class Admin::ServicesController < Admin::BaseController

  load_and_authorize_resource

  main_nav_highlight :content
  sec_nav_highlight :services

  protected
    def end_of_association_chain
      if current_user.has_role? 'admin'
        resource_class
      elsif current_user.has_role? 'chief'
        current_user.department.services
      end
    end
end


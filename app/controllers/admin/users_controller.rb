class Admin::UsersController < Admin::BaseController

  load_and_authorize_resource

  main_nav_highlight :basic
  sec_nav_highlight :users

  protected
  def collection
    if current_user.has_role? 'admin'
      @businesses = end_of_association_chain.all
    elsif current_user.has_role? 'chief'
    elsif current_user.has_role? 'staff'
    end
  end

  def resource
    if current_user.has_role? 'admin'
      @business = end_of_association_chain.find params[:id]
    elsif current_user.has_role? 'chief'
    elsif current_user.has_role? 'staff'
    end
  end
end

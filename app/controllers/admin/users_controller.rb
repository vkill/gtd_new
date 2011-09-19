class Admin::UsersController < Admin::BaseController

  load_and_authorize_resource

  main_nav_highlight :basic
  sec_nav_highlight :users

  def update
    if params[:event]
      result = resource.send("#{params[:event]}!")
      result ? flash[:notice] = t(:state_change_successful) : flash[:error] = resource.errors[:base]
      redirect_to :back
    else
      update! do |success, failure|
        success.html { redirect_to resource_url, :notice => t(:update_successful) }
        failure.html { render :action => :edit }
      end
    end
  end

  protected
    def end_of_association_chain
      if current_user.has_role? 'admin'
        resource_class.not_superadmin
      elsif current_user.has_role? 'chief'
        current_user.department.users.not_superadmin
      end
    end
end


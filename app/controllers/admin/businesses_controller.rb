class Admin::BusinessesController < Admin::BaseController

  load_and_authorize_resource
  include_kindeditor :except => [:index, :show, :destroy]
  main_nav_highlight :issues
  sec_nav_highlight :businesses

  def assign
    @business = resource
    if request.method == "GET"
      @show_colorbox = true
      render :assign, :layout => false
    else
      @business.accepter_id = params[:business][:accepter_id]
      @business.assign_remark = params[:business][:assign_remark]
      if @business.assigned!
        redirect_to collection_url, :notice => t(:assign_successful)
      else
        @show_colorbox = true
        render :assign
      end
    end
  end

  def accept
    @business = resource
    if request.method == "GET"
      @show_colorbox = true
      render :accept, :layout => false
    else
      @business.solution = params[:business][:solution]
      if @business.accepted!
        redirect_to collection_url, :notice => t(:accept_successful)
      else
        @show_colorbox = true
        render :accept
      end
    end
  end

  def finish
    @business = resource
    if request.method == "GET"
      @show_colorbox = true
      render :finish, :layout => false
    else
      @business.result = params[:business][:result]
      if @business.finished!
        redirect_to collection_url, :notice => t(:finish_successful)
      else
        @show_colorbox = true
        render :finish
      end
    end
  end


  def process_feedback
    @business = resource
    @business.feedback.processing! if @business.feedback.pending?
    if request.method == "GET"
      @show_colorbox = true
      render :process_feedback, :layout => false
    else
      update! do |success, failure|
        success.html { redirect_to collection_url, :notice => t(:process_feedback_successful) }
        failure.html { render :process_feedback }
      end
    end
  end

  protected
    def end_of_association_chain
      if current_user.has_role? 'admin'
        resource_class
      elsif current_user.has_role? 'chief'
        current_user.department.businesses
      elsif current_user.has_role? 'staff'
        current_user.accept_businesses
      else
        current_user.businesses
      end
    end

    def resource
      if params[:id]
        if end_of_association_chain.find(params[:id])
          @business = resource_class.find(params[:id])
        end
      else
        @business = resource_class.new
      end
    end

end


class Admin::TasksController < Admin::BaseController

  load_and_authorize_resource
  include_kindeditor :except => [:index, :show, :destroy]
  main_nav_highlight :issues
  sec_nav_highlight :tasks

  def index
    index! do |format|
      format.html { render 'admin/businesses/index' }
    end
  end

  def new
    new! do |format|
      format.html { render 'admin/businesses/new' }
    end
  end

  def create
    @task = end_of_association_chain.new params[:task]
    @task.state = :assigned
    create! do |success, failure|
      success.html { redirect_to resource_url, :notice => t(:create_successful) }
      failure.html { render 'admin/businesses/new' }
    end
  end

  def show
    show! do |format|
      format.html { render 'admin/businesses/show' }
    end
  end

  def edit
    edit! do |format|
      format.html { render 'admin/businesses/edit' }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to resource_url, :notice => t(:update_successful) }
      failure.html { render 'admin/businesses/edit' }
    end
  end

  def accept
    @business = resource
    if request.method == "GET"
      @show_colorbox = true
      render 'admin/businesses/accept', :layout => false
    else
      @business.solution = params[:task][:solution]
      if @business.accepted!
        redirect_to collection_url, :notice => t(:accept_successful)
      else
        @show_colorbox = true
        render 'admin/businesses/accept'
      end
    end
  end

  def finish
    @business = resource
    if request.method == "GET"
      @show_colorbox = true
      render 'admin/businesses/finish', :layout => false
    else
      @business.result = params[:task][:result]
      if @business.finished!
        redirect_to collection_url, :notice => t(:finish_successful)
      else
        @show_colorbox = true
        render 'admin/businesses/finish'
      end
    end
  end

  protected
    def end_of_association_chain
      if current_user.has_role? 'admin'
        resource_class
      elsif current_user.has_role? 'chief'
        current_user.department.tasks
      elsif current_user.has_role? 'staff'
        current_user.accept_tasks
      end
    end

    def resource
      if params[:id]
        if end_of_association_chain.find(params[:id])
          @business = @task = resource_class.find(params[:id])
        end
      else
        @business = @task = resource_class.new
      end
    end
end


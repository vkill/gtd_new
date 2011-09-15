class Admin::ItemsController < Admin::BaseController

  load_and_authorize_resource
  include_kindeditor :except => [:index, :show, :destroy]
  main_nav_highlight :content
  before_filter :set_sec_nav

  def new
    @item = end_of_association_chain.new
    @item.attachments.build if resource_class.name == 'Software'
    new!
  end

  def create
    @item = end_of_association_chain.new(params[params[:default][:resource_class].underscore])
    create!(:notice => t(:create_successful)) { [:admin, resource_class.name.underscore.pluralize] }
  end


  def update
    update!(:notice => t(:update_successful)) { [:admin, resource_class.name.underscore.pluralize] }
  end

  def destroy
    destroy!(:notice => t(:destroy_successful)) { [:admin, resource_class.name.underscore.pluralize] }
  end

  protected
    def resource_class
      params[:default][:resource_class].constantize
    end

  private
    def set_sec_nav
      @sec_nav = params[:default][:resource_class].underscore.pluralize
    end

end


class BusinessesController < ApplicationController

#  layout 'admin'
#  inherit_resources
#  before_filter :authenticate_user!
#  load_and_authorize_resource
#  before_filter :set_current_user
#  include_kindeditor :except => [:index, :show, :destroy]
#  main_nav_highlight :issues
#  sec_nav_highlight :my_businesses

  inherit_resources
  respond_to :html, :xml, :json, :js
  actions :index, :new, :create,:show, :update
  before_filter :find_hot_posts_and_softwares
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :set_current_user

  def add_feedback
    @business = resource
    if request.method == "GET"
      @business.build_feedback
      @show_colorbox = true
      render :add_feedback, :layout => false
    else
      update! do |success, failure|
        success.html { redirect_to collection_url, :notice => t(:add_feedback_successful) }
        failure.html { render :add_feedback }
      end
    end
  end

  protected
    def end_of_association_chain
      current_user.businesses
    end
    def collection
      @businesses = end_of_association_chain.search(params[:search]).page(params[:page])
    end

end


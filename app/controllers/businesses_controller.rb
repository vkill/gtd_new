class BusinessesController < ApplicationController

  layout 'admin'
  inherit_resources
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :set_current_user
  include_kindeditor :except => [:index, :show, :destroy]
  main_nav_highlight :issues
  sec_nav_highlight :my_businesses

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

end


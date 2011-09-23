class ServicesController < ApplicationController

  inherit_resources
  respond_to :html, :xml, :json, :js
  actions :index, :show
  before_filter :find_hot_posts_and_softwares
  main_nav_highlight :issues
  sec_nav_highlight :my_businesses

  protected
    def collection
      @services ||= end_of_association_chain.search(params[:search]).page(params[:page])
    end
end


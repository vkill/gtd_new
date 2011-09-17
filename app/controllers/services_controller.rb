class ServicesController < ApplicationController

  inherit_resources
  respond_to :html, :xml, :json
  actions :index, :show
  before_filter :find_hot_posts_and_softwares

  protected
    def collection
      @services ||= end_of_association_chain.search(params[:search]).page(params[:page])
    end
end


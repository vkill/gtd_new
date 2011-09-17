class SoftwaresController < ApplicationController

  inherit_resources
  respond_to :html, :xml, :json
  actions :index, :show
  before_filter :find_hot_posts_and_softwares

  protected
    def collection
      @softwares ||= end_of_association_chain.list.search(params[:search]).page(params[:page])
    end

end


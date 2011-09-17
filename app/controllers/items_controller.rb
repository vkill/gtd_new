class ItemsController < ApplicationController

  inherit_resources
  actions :index, :show
  before_filter :find_hot_posts_and_softwares

  protected
    def resource_class
      params[:default][:resource_class].constantize
    end

    def collection
      @items ||= end_of_association_chain.page(params[:page])
    end

end


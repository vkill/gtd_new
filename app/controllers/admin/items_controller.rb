class Admin::ItemsController < Admin::BaseController

  load_and_authorize_resource
  include_kindeditor :except => [:index, :show, :destroy]
  main_nav_highlight :content


  def create
    create!(:notice => t(:create_successful)) { [:admin, @items_symbol] }
  end

  def update
    update!(:notice => t(:update_successful)) { [:admin, @items_symbol] }
  end

  def destroy
    destroy!(:notice => t(:destroy_successful)) { [:admin, @items_symbol] }
  end

  protected
    def end_of_association_chain
      set_sec_nav
      @model
    end

  private
    def set_sec_nav
      @main_nav, @item_symbol, @items_symbol, @model, params[:item] =
        case params[:default][:class_name]
        when "Software"
          ["softwares", :software, :softwares, Software, params[:software]]
        when "Post"
          ["posts", :post, :posts, Post, params[:post]]
        end
    end
end


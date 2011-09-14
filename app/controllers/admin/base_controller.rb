class Admin::BaseController < ApplicationController

  layout 'admin'
  inherit_resources
  before_filter :authenticate_user!
  authorize_namespace :namespace => Admin
  before_filter :set_current_user

  def create
    create!(:notice => t(:create_successful)) { collection_url }
  end

  def update
    update!(:notice => t(:update_successful)) { collection_url }
  end
end


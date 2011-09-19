class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    unless current_user
      redirect_to new_user_session_path(:ok_url => request.request_uri)
    else
      redirect_to root_path, :error => t(:can_not_access)
    end
  end

  respond_to :html, :xml, :json

  helper_method :current_user_session, :current_user

  def authorize_namespace
    options = self.class.read_inheritable_attribute(:authorize_namespace)
    authorize!(params[:action].to_sym, options[:namespace])
  end

  class << self
    def main_nav_highlight(name)
      class_eval do
        before_filter { |c| c.instance_variable_set(:@main_nav, name) }
      end
    end

    def sec_nav_highlight(name)
      class_eval do
        before_filter { |c| c.instance_variable_set(:@sec_nav, name) }
      end
    end

    def authorize_namespace(options = {})
      before_filter(:authorize_namespace, options.slice(:only, :except))
      write_inheritable_hash(:authorize_namespace, options)
    end
  end

  def set_current_user
    User.current = current_user
  end


  def find_hot_posts_and_softwares
    @hot_posts = Post.limit(5)
    @hot_softwares = Software.limit(5)
  end


  private
    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default, options = {})
      redirect_to((params[:return_to] || default), options)
    end
end


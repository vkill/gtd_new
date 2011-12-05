class UsersController < Devise::RegistrationsController

  layout :set_layout
  before_filter :authenticate_user!
  main_nav_highlight :main
  sec_nav_highlight :profile

  def create
    unless custom_captcha_valid?
      resource = build_resource
      flash[:alert] = @captcha_message = t("custom_captcha.message")
      render :new
    else
      super
    end
  end

  def edit
    if params[:edit_password]
      @sec_nav = :password
      render_with_scope :edit_password
    else
      @sec_nav = :profile
      render_with_scope :edit
    end
  end

  private
    def set_layout
      case params[:action]
      when 'edit', 'update'
        'admin'
      when 'new', 'create'
        'application'
      else
        false
      end
    end
end


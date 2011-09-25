class PasswordsController < Devise::RegistrationsController

  layout :set_layout
  before_filter :authenticate_user!
  main_nav_highlight :main
  sec_nav_highlight :password

  def create
    unless simple_captcha_valid?
      resource = build_resource
      flash[:alert] = @captcha_message = t("simple_captcha.message.default")
      render :new
    else
      super
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


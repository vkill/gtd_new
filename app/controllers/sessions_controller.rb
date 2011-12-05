class SessionsController < Devise::SessionsController

  layout 'application'
  main_nav_highlight :main
  sec_nav_highlight :logout

  def create
    unless custom_captcha_valid?
      resource = build_resource
      flash[:alert] = @captcha_message = t("custom_captcha.message")
      render :new
    else
      super
    end
  end

  private
    def after_sign_in_path_for(resource)
      unless resource.roles.blank?
        admin_root_path
      else
        root_path
      end
    end
end


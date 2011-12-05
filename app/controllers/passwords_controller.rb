class PasswordsController < Devise::PasswordsController

  def create
    unless custom_captcha_valid?
      resource = build_resource
      flash[:alert] = @captcha_message = t("custom_captcha.message")
      render :new
    else
      super
    end
  end

end


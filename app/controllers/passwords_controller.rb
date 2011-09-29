class PasswordsController < Devise::PasswordsController

  def create
    unless simple_captcha_valid?
      resource = build_resource
      flash[:alert] = @captcha_message = t("simple_captcha.message.default")
      render :new
    else
      super
    end
  end

end


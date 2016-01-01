class UserMailer < ApplicationMailer
  default from: "hello@sendlabrador.com"

  # this is sent from the users controller upon user creation
  # so the user in this case will have the activation_token virtual attribute
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account Activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Reset Password"
  end

  def early_access_signup(user)
    @user = user
    mail to: "chip@sendlabrador.com", cc: "kevin@sendlabrador.com,ben@sendlabrador.com", subject: "I Sense a Disturbance in the Force (#{user.email})"
  end

end

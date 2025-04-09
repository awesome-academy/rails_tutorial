class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    @url = edit_account_activation_url(@user.activation_token, email: @user.email, id: @user.id)
    mail(to: @user.email, subject: "Account Activation")
  end

  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: "Password reset")
  end
end

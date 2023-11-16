class UserMailer < ApplicationMailer
  default from: 'noreply@example.com'

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: 'Password reset'
  end
end

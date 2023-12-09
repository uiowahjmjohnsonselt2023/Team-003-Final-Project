# user_verification_mailer.rb
class UserVerificationMailer < ApplicationMailer
    default from: 'selt2023team003@gmail.com'
    def verification_email(user)
      @user = user
      @verification_url = verify_account_url(token: @user.verification_token)
      mail(to: @user.email, subject: 'Verify Your Account')
    end
end
  
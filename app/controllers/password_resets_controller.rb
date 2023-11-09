class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:password_reset][:username], email: params[:password_reset][:email])

    if @user
      # generate a password reset token and reset the password
      @user.update(reset_token: SecureRandom.urlsafe_base64)
      @user.update(password: 'new_password')
      flash[:notice] = "Password reset successfully. Your new password is 'new_password'."
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid username or email."
      render :new
    end
  end
  def edit
  end

  def update
  end
end

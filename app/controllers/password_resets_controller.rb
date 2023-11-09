class PasswordResetsController < ApplicationController
  def new
  end

  def create
    username = params.dig(:password_reset, :username)
    email = params.dig(:password_reset, :email)

    if username.blank? || email.blank?
      flash.now[:alert] = "Username and email are required fields."
      render :new
      return
    end

    @user = User.find_by(username: username, email: email)

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
    @user = User.find_by(reset_token: params[:id])

    if @user.nil?
      flash[:alert] = "Password reset link has expired. Please request a new one."
      redirect_to new_password_reset_path
    end
  end

  def update
    @user = User.find_by(reset_token: params[:id])

    if @user.nil?
      flash[:alert] = "Password reset link has expired. Please request a new one."
      redirect_to new_password_reset_path

    elsif @user.update(user_params)
      # clear the password reset token
      @user.update(reset_token: nil)
      flash[:notice] = "Password successfully reset."
      redirect_to root_path
    else
      render :edit
    end
  end
end

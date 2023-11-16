class PasswordResetsController < ApplicationController
  def create
    if params[:password_reset].blank? || params[:password_reset][:email].blank?
      flash.now[:alert] = "Email can't be blank"
      render 'new' and return
    end

    @user = User.find_by(email: params[:password_reset][:email].downcase)

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:alert] = "Email address not found"
      render 'new'
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
  end

  def update
    @user = User.find_by(email: params[:email])
    if @user.reset_sent_at < 2.hours.ago
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    elsif @user.update(user_params)
      flash[:success] = "Password has been reset."
      redirect_to login_url
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end


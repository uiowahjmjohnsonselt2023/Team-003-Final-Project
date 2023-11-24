class PasswordResetsController < ApplicationController

  # create action initiates the password reset process for a user
  def create
    # check if the email parameter is present, if not, set a flash message and render the 'new' password reset view
    if params[:password_reset].blank? || params[:password_reset][:email].blank?
      flash.now[:alert] = "Email can't be blank"
      render 'new' and return
    end

    # find the user by the provided email address, case-insensitively
    @user = User.find_by(email: params[:password_reset][:email].downcase)

    # if the user exists, create a reset digest, send a password reset email, set a flash message and redirect to the home page
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      # if the user does not exist, set a flash message indicating the email was not found and render the 'new' view
      flash.now[:alert] = "Email address not found"
      render 'new'
    end
  end

  # edit action is called when the user clicks the link in the password reset email
  def edit
    # finds the user by the email provided in the link parameters
    @user = User.find_by(email: params[:email])
  end


  # update action resets the user's password
  def update
    # finds the user by the email provided in the link parameters
    @user = User.find_by(email: params[:email])

    # check if the password reset link has expired (2 hours)
    if @user.reset_sent_at < 2.hours.ago
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url

    elsif @user.update(user_params)
      # if the user successfully updates their password, set a flash success message and redirect to the login page
      flash[:success] = "Password has been reset."
      redirect_to login_path

    else
      # if the update fails (e.g., password confirmation doesn't match), render the edit view again
      render 'edit'
    end
  end

  private

  # method that ensures that only the permitted attributes (password and password confirmation) are passed to the model for update
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end


# The controller handles user registrations
class RegistrationsController < ApplicationController
  # render the registration form
  def new
    @user = User.new
  end

  # create a new user based on input form
  # if successful --> redirect to the root path with a success notice
  # else,         --> render the registration form again
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Signup successful!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  # strong parameters to whitelist user attributes
  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :bio, :profile_picture)
  end
end
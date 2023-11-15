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
      @product = @user.products.create(
        title: "Default Product Title",
        condition: "New",
        location: "Default Location",
        price: 0.0,
        description: "Default Product Description"
      )

      session[:user_id] = @user.id
      flash[:notice] = 'Signup successful!'
      redirect_to login_path
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
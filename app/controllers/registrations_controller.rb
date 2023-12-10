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

      # Generate a verification token and save it to the user
      @user.update(verification_token: SecureRandom.urlsafe_base64)
      # Send email with verification link
      UserVerificationMailer.verification_email(@user).deliver_later

      redirect_to root_path
    else
      render 'new'
    end
  end

  def create_from_omniauth
    auth_hash = request.env['omniauth.auth']
    uid = auth_hash.uid
    username = auth_hash.info['nickname']
    if auth_hash.info['name'] != nil
      name = auth_hash.info['name']
    else
      name = username
    end
    password = SecureRandom.hex
    email = username + "@github.com"
    if auth_hash.info['email'] != nil
      email = auth_hash.info['email']
    end
    @user = User.find_or_create_by(email: email) do |user|
      user.username = username
      user.email = email
      user.password = password
      user.name = name
    end
    if @user.persisted?
      session[:user_id] = @user.id
      flash[:notice] = 'Logged in successfully.'
      redirect_to root_path
    else
      flash[:alert] = "Log in failed"
      redirect_to root_path
    end
  end

  private

  # strong parameters to whitelist user attributes
  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :bio, :profile_picture)
  end
end
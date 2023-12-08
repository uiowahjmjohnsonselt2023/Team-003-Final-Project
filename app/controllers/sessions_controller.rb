require 'securerandom'
# This controller for handles user sessions, including login and logout actions
class SessionsController < ApplicationController

  # authenticate user login credentials
  def create
    user = User.find_by(username: params[:username])

    # create a session for the user and redirect on success
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged in successfully.'

      # respond with a Turbo Stream to update the login form or other parts of the page
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('login_form', partial: 'shared/login_success') }
      end
    else

      # display an error message and re-render the login form on failure
      flash.now[:alert] = 'Username or password is invalid'
      render :new
    end
  end

  def create_from_omniauth
    auth_hash = request.env['omniauth.auth']
    uid = auth_hash.uid
    username = auth_hash.info['nickname']
    password = SecureRandom.hex
    email = username + "@github.com"
    if auth_hash.info['email'] != nil
      email = auth_hash.info['email']
    end
    @user = User.find_or_create_by(email: email) do |user|
      user.username = username
      user.email = email
      user.password = password
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

  # log out the user and redirect to the root page (back to the login form)
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to login_path
  end
end

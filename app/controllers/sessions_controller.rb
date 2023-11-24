# This controller for handles user sessions, including login and logout actions
class SessionsController < ApplicationController
  # displays the login form
  def new
  end

  # authenticate user login credentials
  def create
    user = User.find_by(username: params[:username])

    # create a session for the user and redirect on success
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged in successfully.'
      # redirect_to root_path

      # respond with a Turbo Stream to update the login form or other parts of the page
      respond_to do |format|
        format.html { redirect_to profile_path }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('login_form', partial: 'shared/login_success') }
      end
    else

      # display an error message and re-render the login form on failure
      flash.now[:alert] = 'Username or password is invalid'
      render :new
    end
  end

  # forgot password functionality
  def forgot_password
  end

  # log out the user and redirect to the root page (back to the login form)
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to login_path
  end
end


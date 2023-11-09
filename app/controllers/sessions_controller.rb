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
      redirect_to root_path
    else

      # display an error message and re-render the login form on failure
      flash.now[:alert] = 'Username or password is invalid'
      render :new
    end
  end

  # log out the user and redirect to the root page (back to the login form)
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end


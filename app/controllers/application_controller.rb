class ApplicationController < ActionController::Base
  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to login_url, alert: "You must be logged in to access this page." if current_user.nil?
  end

end

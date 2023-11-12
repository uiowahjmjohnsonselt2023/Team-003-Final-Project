class ApplicationController < ActionController::Base
  before_action :require_login, except: [:new]
  before_action :initialize_cart

  helper_method :current_user

  private
  def require_login
    unless user_logged_in?
      flash[:alert] = 'You need to be logged in to make a purchase.'
      redirect_to login_path
    end
  end
  def user_logged_in?
    current_user.present?
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def initialize_cart
    session[:cart] ||= Cart.new
  end
  def authenticate_user!
    redirect_to login_url, alert: "You must be logged in to access this page." if current_user.nil?
  end

end

class ApplicationController < ActionController::Base
  before_action :initialize_cart
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    nil
  end

  def require_login
    unless logged_in?
      flash[:alert] = 'You must be logged in to access this section'
      redirect_to login_url
    end
  end
  def logged_in?
    current_user.present?
  end
  def initialize_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def authenticate_user!
    redirect_to login_url, alert: 'You must be logged in to access this page.' if current_user.nil?
  end
end


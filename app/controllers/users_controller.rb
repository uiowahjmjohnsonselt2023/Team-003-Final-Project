class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  before_action :set_user, only: [:show]

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @feedbacks = @user.feedbacks
    @orders = @user.orders.includes(:tracking)
  end

  private

  def authenticate_user
    unless session[:user_id]
      flash[:alert] = "You must be logged in to access this page."
      redirect_to login_path
    else
      @current_user = User.find(session[:user_id])
    end

    def set_user
      @user = User.find_by(id: params[:id]) || current_user
    end
  end
end


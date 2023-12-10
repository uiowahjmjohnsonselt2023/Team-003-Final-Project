class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  before_action :set_user, only: [:show]
  before_action :set_admin, only: [:show]

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @feedbacks = @user.feedbacks
    @orders = @user.orders.includes(:tracking)
  end
  def following
    @user = User.find(params[:id])
    @following = @user.following
  end
  
  def follow
    user_to_follow = User.find(params[:id])

    if current_user.follow(user_to_follow)
      flash[:notice] = "You are now following #{user_to_follow.username}."
    else
      flash[:alert] = "Unable to follow #{user_to_follow.username}."
    end

    redirect_to user_path(user_to_follow)
  end

  def unfollow
    user_to_unfollow = User.find(params[:id])

    if current_user.unfollow(user_to_unfollow)
      flash[:notice] = "You have unfollowed #{user_to_unfollow.username}."
    else
      flash[:alert] = "Unable to unfollow #{user_to_unfollow.username}."
    end

    redirect_to user_path(user_to_unfollow)
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

    def set_admin
      @admin = User.find_by(admin: true)
    end
  end
end


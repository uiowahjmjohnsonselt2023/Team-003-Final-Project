class UsersController < ApplicationController
  before_action :set_user, only: [:verify, :unverify]
  before_action :check_admin, only: [:verify, :unverify]

  def admin
    @users = User.all
  end

  def verify
    user = User.find(params[:id])
    if user.verify!
      redirect_to root_path, notice: 'User was successfully verified.'
    else
      redirect_to root_path, alert: 'User could not be verified.'
    end
  end

  def unverify
    user = User.find(params[:id])
    if user.unverify!
      redirect_to root_path, notice: 'User was successfully unverified.'
    else
      redirect_to root_path, alert: 'User could not be unverified.'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_admin
    redirect_to(root_url) unless current_user.admin?
  end
end

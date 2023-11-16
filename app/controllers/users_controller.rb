class UsersController < ApplicationController
  before_action :set_user, only: [:verify, :unverify]
  before_action :check_admin, only: [:verify, :unverify]

  def admin
    @users = User.all
  end

  def verify
    @user.verify!
    redirect_back(fallback_location: root_path, notice: 'User successfully verified.')
  end

  def unverify
    @user.unverify!
    redirect_back(fallback_location: root_path, notice: 'User verification removed.')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_admin
    redirect_to(root_url) unless current_user.admin?
  end
end

class HomeController < ApplicationController
  def index
    @greeting = "Hello, Welcome to the Market"
  end

  def profile
    @user = current_user
    @listings = @user.listings
  end
end
class HomeController < ApplicationController
  def index
    @top_sellers = User.top_sellers
    @featured_products = Product.featured
    @top_rated = User.top_rated
  end

  def profile
    @user = current_user
    @listings = @user.listings
  end
end
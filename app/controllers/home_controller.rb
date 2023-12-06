class HomeController < ApplicationController
  def index
    @top_sellers = User.top_sellers
    @featured_products = Product.featured
  end

  def profile
    @user = current_user
    @listings = @user.listings
  end
end
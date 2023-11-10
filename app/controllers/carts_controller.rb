class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
  # assumes that each user has one cart and `current_user` is a method that returns the logged-in user
  @cart = current_user.cart || current_user.build_cart
  end
end

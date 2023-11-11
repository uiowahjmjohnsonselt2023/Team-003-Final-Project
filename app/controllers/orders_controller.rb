class OrdersController < ApplicationController
  def new
    @cart_items = current_user.cart.cart_items
    @order = Order.new
  end

  def create
  end
end


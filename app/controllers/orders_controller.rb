class OrdersController < ApplicationController
  before_action :require_login, only: [:new, :create]
  def new
    @cart = current_user.cart
    if @cart.cart_items.empty?
      @cart_empty = true
    else
      @cart_items = @cart.cart_items
      @order = Order.new
    end
  end

  def create
  end
end
def order_params
  params.require(:order).permit(:street, :city, :postal_code, :credit_card_number, :expiration_date, :cvv, :quantity, :email, :phone, :additional_instructions, :save_payment_info)
end
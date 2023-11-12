class OrdersController < ApplicationController
  before_action :require_login, only: [:new, :create]
  before_action :set_cart_and_items, only: [:new, :create]
  def new
    @cart_empty = @cart.cart_items.empty?
    @order = Order.new unless @cart_empty
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'pending'

    if @order.valid?
      if process_payment(@order)
        @order.save

        # save each cart item to the order
        @cart.cart_items.each do |item|
          @order.order_items.create(product: item.product, quantity: item.quantity)
        end
        @cart.empty_cart!
        redirect_to order_path(@order), notice: "Order was successfully placed."
      else
        flash.now[:error] = "There was a problem with the payment. Please try again."
        render :new
      end
    else
      flash.now[:error] = "Please complete all required fields."
      render :new
    end
  end

  private

  def set_cart_and_items
    @cart = current_user.cart || Cart.new           # ensure @cart is not nil
    @cart_items = @cart.cart_items.presence || []   # ensure @cart_items is not nil
  end

  def order_params
    params.require(:order).permit(
      :street, :city, :postal_code, :credit_card_number,
      :expiration_date, :cvv, :email, :phone, :additional_instructions,
      :save_payment_info
    )
  end
  def process_payment(order)
    true
  end
end


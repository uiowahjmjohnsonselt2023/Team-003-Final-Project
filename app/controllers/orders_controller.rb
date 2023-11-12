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
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'pending'

    if @order.save
      # call method to handle payment like `process_payment`
      if process_payment(@order)
        # Empty the current cart since the order has been placed
        current_cart.empty_cart!

        # redirect to the order show page with a success message
        flash[:success] = "Order successfully placed! You can leave feedback once the order is fulfilled."
        redirect_to order_path(@order)
      else
        # handle payment failure case
        flash.now[:error] = "There was a problem with the payment. Please try again."
        render :new
      end
    else
      flash.now[:error] = "There was a problem placing your order. Please check your information."
      render :new
    end
  end

  def order_params
  params.require(:order).permit(:street, :city, :postal_code, :credit_card_number, :expiration_date, :cvv, :quantity, :email, :phone, :additional_instructions, :save_payment_info)
  end

  def process_payment(order)
    true
  end
end


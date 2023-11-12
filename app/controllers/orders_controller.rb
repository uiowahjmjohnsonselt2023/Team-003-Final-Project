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

    if @order.valid?
      if process_payment(@order)
        @order.save
        current_cart.cart_items.each do |item|

          # save each item as part of the order
          @order.order_items.create(product: item.product, quantity: item.quantity)
        end
        current_cart.empty_cart!
        redirect_to order_path(@order), notice: "Order was successfully placed."
      else
        flash.now[:error] = "There was a problem with the payment. Please try again."
        render :new
      end
    else
      # show validation errors on the form
      flash.now[:error] = "Please complete all required fields."
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


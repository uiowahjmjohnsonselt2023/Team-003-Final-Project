class OrdersController < ApplicationController
  before_action :require_login, only: [:new, :create]
  before_action :set_cart_and_items, only: [:new, :create]

  def new
    if @cart.cart_items.empty?
      redirect_to root_path, alert: "Your cart is empty."
    else
      @order = Order.new
    end
  end

  def create
    Rails.logger.debug "Processing new order..."
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'pending'

    if @order.valid?
      if process_payment(@order)
        ActiveRecord::Base.transaction do
          @order.save!
          @cart.cart_items.each do |cart_item|
            @order.order_items.create!(product: cart_item.product, quantity: cart_item.quantity)
          end
          @cart.destroy! # This empties the cart by destroying it and its associated items.
        end
        redirect_to order_path(@order), notice: "Order was successfully placed."
      else
        Rails.logger.error "Payment processing failed."
        flash.now[:error] = "There was a problem with the payment. Please try again."
        render :new
      end
    else
      flash.now[:error] = @order.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path # or your login route
    end
  end

  def set_cart_and_items
    @cart = current_user.cart || Cart.new
    @cart_items = @cart.cart_items
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


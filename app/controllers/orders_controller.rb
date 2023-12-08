class OrdersController < ApplicationController
  before_action :require_login, only: [:new, :create, :show, :index]       # require login for specific actions
  before_action :set_cart_items, only: [:new, :create]                     # set cart items for specific actions

  # display a new order form
  def new
    @order = Order.new
    redirect_to cart_path, alert: "Your cart is empty." if @cart_items.empty?
  end

  # show details of an order
  def show
    @order = Order.find_by(id: params[:id])
    unless @order
      # if the order is not found, redirect to a safe page with an error message
      redirect_to root_path, alert: "Order not found."
      return
    end
  end
  def create
    @cart = current_user.cart
    @cart_items = @cart.cart_items if @cart.present?

    if @cart_items.blank?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    @order = current_user.orders.build(order_params)

    if @order.save
      # iterate through the cart items and add associated products to the order
      @cart_items.each do |cart_item|
        product = cart_item.product
        @order.order_items.create(product: product, quantity: cart_item.quantity)
      end

      @tracking = @order.create_tracking(tracking_number: SecureRandom.uuid, status: :processing)

      @tracking = @order.create_tracking(
        tracking_number: SecureRandom.uuid,
        status: :processing,
        shipping_carrier: 'UPS'
      )

      @cart.destroy
      session[:cart_id] = nil
      redirect_to order_path(@order), notice: "Your order has been placed."

    else
      flash.now[:alert] = @order.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end


  private

  # set cart items based on the current user's cart
  def set_cart_items
    @cart = current_user.cart
    @cart_items = @cart.cart_items if @cart.present?
  end

  # require user login for specific actions
  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

  def process_payment(order)
    true
  end

  # define strong parameters for the order
  def order_params
    params.require(:order).permit(
      :street, :city, :postal_code, :credit_card_number,
      :expiration_date, :email, :phone, :additional_instructions,
      :save_payment_info
    )
  end
end







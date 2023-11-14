class OrdersController < ApplicationController
  before_action :require_login, only: [:new, :create, :show, :index]
  before_action :set_cart_items, only: [:new, :create]

  def new
    @order = Order.new
    redirect_to cart_path, alert: "Your cart is empty." if @cart_items.empty?
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      @cart.cart_items.each do |cart_item|
        @order.order_items.create(product: cart_item.product, quantity: cart_item.quantity)
      end
      @cart.cart_items.destroy_all
      redirect_to order_path(@order), notice: "Your order has been placed."
    else
      render :new
    end
  end
  private


    def set_cart_items
      @cart = current_user.cart
      @cart_items = @cart.cart_items if @cart.present?
    end

    def order_params
      params.require(:order).permit(
        :street, :city, :postal_code, :credit_card_number,
        :expiration_date, :cvv, :email, :phone, :additional_instructions,
        :save_payment_info
      )
    end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
    end

    def process_payment(order)
      true
    end
  end





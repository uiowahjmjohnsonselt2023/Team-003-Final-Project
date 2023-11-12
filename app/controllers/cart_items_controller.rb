class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:update, :destroy]
  def create
    cart = current_user.cart || current_user.create_cart

    cart_item = cart.cart_items.find_or_initialize_by(product_id: params[:product_id])

    cart_item.quantity ||= 0
    cart_item.quantity += 1

    if cart_item.save
      flash[:notice] = "Product added to cart!"
      redirect_to cart_path(cart)
    else
      flash[:alert] = "There was a problem adding the product to the cart."
      redirect_to product_path(params[:product_id])
    end
  end

  def update
    case params[:change]
    when 'increase'
      @cart_item.quantity += 1
    when 'decrease'
      @cart_item.quantity -= 1 if @cart_item.quantity > 1
    end

    if @cart_item.save
      message = params[:change] == 'increase' ? 'Item added to cart.' : 'Item quantity decreased.'
      redirect_to cart_path, notice: message
    else
      redirect_to cart_path, alert: 'There was a problem updating the item.'
    end
  end
  def destroy
    @cart_item.destroy
    redirect_to cart_path, notice: 'Item was removed from cart.'
  end

  private
  def set_cart_item
    @cart_item = CartItem.find_by_id(params[:id])

    if @cart_item.nil?
      redirect_to cart_path, alert: 'Item not found in cart.'
    end
  end
end

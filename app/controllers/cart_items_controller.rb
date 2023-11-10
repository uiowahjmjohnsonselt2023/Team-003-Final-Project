class CartItemsController < ApplicationController
  before_action :authenticate_user!

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
end

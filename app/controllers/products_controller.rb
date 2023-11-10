class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
  end

  def message_seller
  end

  def write_review
  end
end

class FavoritesController < ApplicationController
  before_action :set_product, only: [:create, :destroy]
  before_action :authenticate_user

  def index
    @favorites = current_user.favorites
    @favorite_products = current_user.favorite_products
  end
  def create
    if Favorite.create(favorited: @product, user: current_user)
      redirect_to @product, notice: 'Product has been favorited'
    else
      redirect_to @product, alert: 'Something went wrong...'
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(product_id: @product.id)
    if favorite
      favorite.destroy
      redirect_to favorites_path, notice: 'Favorite was successfully removed.'
    else
      redirect_to favorites_path, alert: 'Product was not found in your favorites'
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to favorites_path, alert: 'Product not found'
    end
  end

  def authenticate_user
    redirect_to root_path unless logged_in?
  end
end


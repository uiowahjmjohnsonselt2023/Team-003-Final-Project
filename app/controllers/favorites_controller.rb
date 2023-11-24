class FavoritesController < ApplicationController
  # actions to find the product before 'create' and 'destroy' actions
  before_action :set_product, only: [:create, :destroy]

  # ensures user is authenticated before any action
  before_action :authenticate_user

  # display the current user's favorite products
  def index
    @favorites = current_user.favorites
    @favorite_products = current_user.favorite_products
  end

  # add a product to the user's favorites
  def create
    # attempting to create a new favorite
    if Favorite.create(favorited: @product, user: current_user)
      redirect_to @product, notice: 'Product has been favorited'
    else
      redirect_to @product, alert: 'Something went wrong...'
    end
  end

  # remove a product from the user's favorites
  def destroy
    # finding the favorite by product_id
    favorite = current_user.favorites.find_by(product_id: @product.id)
    if favorite
      favorite.destroy
      redirect_to favorites_path, notice: 'Favorite was successfully removed.'
    else
      redirect_to favorites_path, alert: 'Product was not found in your favorites'
    end
  end

  private

  # find the product based on provided ID
  def set_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to favorites_path, alert: 'Product not found'
    end
  end

  # redirects to login page if user is not logged in
  def authenticate_user
    unless logged_in?
      flash[:alert] = 'You must be logged in to view favorites.'
      redirect_to login_path
    end
  end
end


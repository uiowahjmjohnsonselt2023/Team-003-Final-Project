class ListingsController < ApplicationController
  before_action :set_listing, only: [:destroy]
  before_action :authenticate_user!, only: [:destroy]

  def show
    @listing = Listing.find(params[:id])
  end

  def index
    @user = User.find(params[:user_id])
    @listings = @user.listings
  end

  def new
    @listing = Listing.new
  end
  def create
    @listing = current_user.listings.new(listing_params)

    if @listing.save
      flash[:notice] = 'Listing added!'
      redirect_to user_listings_path(current_user)
    else
      flash[:error] = 'Failed to add listing'
      render :new
    end
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
      flash[:notice] = 'Listing updated!'
      redirect_to listing_path(@listing)
    else
      flash[:error] = 'Failed to update listing'
      render :edit
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to user_listings_path(@listing.user_id), notice: 'Listing was successfully deleted.'
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
    redirect_to(root_path, alert: 'You are not authorized to perform this action.') unless @listing.user == current_user
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :condition, :quantity, :images, :product_id)
  end
end
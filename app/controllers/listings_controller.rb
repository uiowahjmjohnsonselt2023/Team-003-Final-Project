class ListingsController < ApplicationController
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
      redirect_to product_path(@listing.product)
    else
      flash[:error] = 'Failed to add listing'
      render :new
    end
  end

  def edit
    @listing = Listing.find(params[:id])
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
    flash[:notice] = 'Listing removed'
    redirect_to listings_path
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :condition, :quantity, :images, :product_id)
  end
end
class ListingsController < ApplicationController

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :condition, :quantity, :images, :user_id)
  end
  def show
    id = params[:id] # retrieve listing ID from URI route
    @listing = Listing.find(id)
  end

  def index
    @listings = Listing.all
  end

  def new
    # default: render 'new' template
    unless current_user
      flash[:error] = 'You must be logged in to create a listing.'
      redirect_to login_path
    end
    @listing = Listing.new
  end

  def create
    if current_user
      @user = current_user
      #if listing contains all required fields, save it

      @listing = @user.listings.new(listing_params)
      if @listing.save
        flash[:notice] = 'Listing added!'
        redirect_to listings_path
      else
        flash[:error] = 'Failed to add listing'
        render :new
      end
    else
      flash[:error] = 'You must be logged in to create a listing.'
      redirect_to login_path
    end

    end
end

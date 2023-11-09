class ListingsController < ApplicationController

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :condition, :quantity, :images)
  end
  def show
    id = params[:id] # retrieve movie ID from URI route
    @listing = Listing.find(id)
  end

  def index
    @listings = Listing.all
  end

  def new
    # default: render 'new' template
        @listing = Listing.new
  end

  def create
    @listing = Listing.create!(listing_params)
    if @listing.save
      flash[:notice] = 'Listing added!'
      redirect_to listings_path
    else
      flash[:error] = 'Failed to add listing'
      render :new
    end
    end
end

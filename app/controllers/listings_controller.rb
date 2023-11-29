class ListingsController < ApplicationController

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :condition, :quantity, :images)
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
    end
end

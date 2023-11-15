class ProductsController < ApplicationController

  # search for products based on the provided query (search bar on the navigation bar)
  def search
    if params[:query].present?
      @products = Product.where('title LIKE ?', "%#{params[:query]}%")
      @products = Product.where('LOWER(title) LIKE LOWER(?)', "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end

  # display a list of all products
  def index
    @products = Product.all
  end

  # show details of a single product and its reviews
  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    @review = Review.new
  end

  # some action without a clear comment
  def some_action
    @user = User.find_by(id: some_id)
  end

  # add a product to the user's favorites
  def add_to_favorites
    @product = Product.find(params[:id])
    current_user.favorites.create(product: @product)
    flash[:notice] = "Product added to favorites."
    redirect_to product_path(@product)
  end

  def message_seller
  end

  # write a review for a product
  def write_review
    @product = Product.find(params[:id])
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      flash[:notice] = "Review successfully submitted!"
      redirect_to product_path(@product)
    else
      flash[:alert] = "There was a problem submitting your review."
      render :show
    end
  end

  private

  # define strong parameters for the review
  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

class ProductsController < ApplicationController

  # search for products based on the provided query (search bar on the navigation bar)
  def search
    @products = Product.all

    # existing search logic
    @products = @products.order(sort_by_params(params[:sort_by])) if params[:sort_by].present?

    # if there's a search query, filter products by title or description
    if params[:query].present?
      @products = @products.where('LOWER(title) LIKE :search OR LOWER(description) LIKE :search', search: "%#{params[:query].downcase}%")
    end

    # filter by category if the category parameter is present
    @products = @products.where(category: params[:category]) if params[:category].present?

    # filter by condition if the condition parameter is present
    @products = @products.where(condition: params[:condition]) if params[:condition].present?

    # filter by price range if the price_range parameter is present
    if params[:price_range].present?
      range = params[:price_range].split('-').map { |p| p.delete('$').to_i }
      @products = @products.where(price: range[0]..range[-1])
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

  # helper method to determine the sorting parameters
  def sort_by_params(sort_option)
    case sort_option
    when 'newest'
      'created_at DESC'
    when 'best_selling'
    when 'price_asc'
      'price ASC'
    when 'price_desc'
      'price DESC'
    when 'featured'
      'featured DESC, created_at DESC'
    else
      'created_at DESC'
    end

    def apply_sorting(products, sort_option)
      case sort_option
      when 'best_selling'
        products.best_selling
      when 'featured'
        products.featured
      else
        products.order(sort_by_params(sort_option))
      end
    end

  # define strong parameters for the review
  def review_params
    params.require(:review).permit(:content, :rating)
  end
  end
end



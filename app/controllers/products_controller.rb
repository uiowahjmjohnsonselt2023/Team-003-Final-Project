class ProductsController < ApplicationController

  # display a list of all products
  def index
    @products = Product.all
  end

  # show details of a single product and its reviews
  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    # initialize an empty review object for the form
    @review = Review.new

    # show seller's rating
    @seller_rating = @product.user.average_rating
  end

  # add a product to the user's favorites
  def add_to_favorites
    @product = Product.find(params[:id])
    current_user.favorites.create(product: @product)
    flash[:notice] = "Product added to favorites."
    redirect_to product_path(@product)
  end

  # (placeholder for 'message_seller' action if needed)

  # write a review for a product
  def write_review
    @product = Product.find(params[:id])
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      flash[:notice] = "Review successfully submitted!"
      redirect_to products_path(@product)
    else
      flash[:alert] = "There was a problem submitting your review."
      render :show
    end
  end

  # search for products based on the provided query and filters
  def search
    @products = Product.all
    apply_search_query(params[:query])
    apply_filters(params[:category], params[:condition], params[:price_range])
    apply_sorting(params[:sort_by])
  end

  private

  # apply search query on products
  def apply_search_query(query)
    if query.present?
      search_term = "%#{query.downcase}%"
      @products = @products.where('LOWER(title) LIKE :search OR LOWER(description) LIKE :search', search: search_term)
    end
  end

  # apply category, condition, and price range filters
  def apply_filters(category, condition, price_range)
    @products = @products.where(category: category) if category.present?
    @products = @products.where(condition: condition) if condition.present?
    apply_price_range_filter(price_range) if price_range.present?
  end

  # apply price range filter
  def apply_price_range_filter(price_range)
    range = price_range.split('-').map { |p| p.delete('$').to_i }
    @products = @products.where(price: range[0]..range[-1])
  end

  # sort products based on the selected criteria
  def apply_sorting(sort_by)
    @products = apply_sorting_logic(@products, sort_by) if sort_by.present?
  end

  # define strong parameters for the review
  def review_params
    params.require(:review).permit(:content, :rating)
  end

  # determine the sorting logic based on the sort_by parameter
  def apply_sorting_logic(products, sort_by)
    case sort_by
    when 'best_selling'
      products.best_selling
    when 'featured'
      products.featured
    else
      products.order(sort_by_params(sort_by))
    end
  end

  # helper method to determine the sorting parameters
  def sort_by_params(sort_option)
    case sort_option
    when 'newest'
      'created_at DESC'
    when 'price_asc'
      'price ASC'
    when 'price_desc'
      'price DESC'
    else
      'created_at DESC' # default sorting by newest
    end
  end
end




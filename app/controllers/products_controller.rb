class ProductsController < ApplicationController

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

    if price_range.present?
      range = price_range.split('-').map { |p| p.delete('$').to_i }
      @products = @products.where(price: range[0]..range[-1])
    end
  end

  # sort products based on the selected criteria
  def apply_sorting(sort_by)
    case sort_by
    when 'rating'
      @products = @products.joins(:reviews)
                           .select('products.*, COALESCE(AVG(reviews.rating), 0) as average_rating')
                           .group('products.id')
                           .order('average_rating DESC')
    end
  end

  # determine the sorting criteria based on the provided sort_by parameter
  def sort_by_params(sort_by)
    case sort_by
    when 'newest'
      { created_at: :desc }
    when 'best_selling'
      { sales_count: :desc }
    when 'price_low_to_high'
      { price: :asc }
    when 'price_high_to_low'
      { price: :desc }
    when 'featured'
      { featured: :desc, created_at: :desc }
    when 'rating'
      # Ensure you have an average_rating method or column in your Product model
      'average_rating DESC'
    else
      { created_at: :desc } # default sorting by newest
    end
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



class ProductsController < ApplicationController
  before_action :set_product, only: [:message_seller, :create_bid]
  before_action :authenticate_user, only: [:message_seller, :create_bid]
  before_action :require_login, only: [:new, :create]

  def product_params
    params.require(:product).permit(:title,
                                    :description,
                                    :price,
                                    :condition,
                                    :location,
                                    :category_id,
                                    :auction_enabled,
                                    :auction_start_time,
                                    :auction_end_time
                                    )
  end

  # display a list of all products
  def index
    if params[:user_id]
      @products = Product.where(user_id: params[:user_id])
    else
      @products = Product.all
    end
  end

  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      flash[:notice] = 'Product added!'
      redirect_to product_path(@product)
    else
      flash[:error] = 'Failed to add product'
      render :new
    end
  end

  # show details of a single product and its reviews
  def show
    @product = Product.find(params[:id])
    @listings = @product.listings
    @reviews = @product.reviews
    @bids = @product.bids.order(amount: :desc)
    # initialize an empty review object for the form
    @review = Review.new

    # show seller's rating
    @seller_rating = @product.user.average_rating.round(1)

    @related_products = Product.where(category_id: @product.category_id).limit(3)
  end

  def edit
    @product = current_user.products.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Product not found or access denied."
  end

  def update
    @product = current_user.products.find(params[:id])

    if @product.update(product_params)
      flash[:notice] = "Product successfully updated!"
      redirect_to product_path(@product)
    else
      flash[:error] = "Failed to update product"
      render :edit
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Product not found or access denied."
  end

  def destroy
    product = current_user.products.find(params[:id])
    product.destroy
    flash[:notice] = "Product successfully deleted."

    # redirect to the user's own listings page
    redirect_back(fallback_location: user_listings_path(current_user))
  end

  # add a product to the user's favorites
  def add_to_favorites
    @product = Product.find(params[:id])
    current_user.favorites.create(product: @product)
    flash[:notice] = "Product added to favorites."
    redirect_to product_path(@product)
  end

  def message_seller
    if current_user.id == @product.user_id
      redirect_to product_path(@product), alert: "You cannot send a message to yourself."
    else
      conversation = Conversation.find_or_create_by(sender_id: current_user.id, recipient_id: @product.user_id, product_id: @product.id)
      redirect_to conversation_path(conversation)
    end
  end

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
    @promoted_products = Product.where(is_promoted: true)
    @products = Product.all
    apply_search_query(params[:query])
    apply_filters(params[:category], params[:condition], params[:price_range])
    apply_sorting(params[:sort_by])

    render 'search'
  end
  def create_bid
    @product = Product.find(params[:id])
    amount = params[:bid_amount].to_f

    if @product.auction_enabled && @product.auction_end_time > Time.now && amount > @product.bid
      @product.update(bid: amount)
      flash[:notice] = 'Bid placed successfully!'
    else
      flash[:alert] = 'Invalid bid!'
    end

    redirect_to product_path(@product)
  end
  def end_auction
    @product = Product.find(params[:id])

    if @product.auction_enabled && @product.auction_end_time <= Time.now
      # Award the product to the highest bidder
      winner = @product.highest_bidder
      @product.update(sold_to: winner, auction_enabled: false)
      flash[:notice] = 'Auction ended successfully!'
    else
      flash[:alert] = 'Auction cannot be ended at this time!'
    end

    redirect_to product_path(@product)
  end

  def bid_params
    params.require(:bid).permit(:amount)
  end

  def promote
    @product = current_user.products.find(params[:id])
    if @product.update(is_promoted: true)
      flash[:notice] = "Product successfully promoted!"
    else
      flash[:error] = "Failed to promote product"
    end
    redirect_to product_path(@product)
  end

  def unpromote
    @product = current_user.products.find(params[:id])
    if @product.update(is_promoted: false)
      flash[:notice] = "Product promotion removed."
    else
      flash[:error] = "Failed to remove product promotion"
    end
    redirect_to product_path(@product)
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
    @products = @products.where(category_id: category) if category.present?
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

  def set_product
    @product = Product.find(params[:id])
  end

  def authenticate_user
    redirect_to login_path, alert: 'Please log in.' unless current_user
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




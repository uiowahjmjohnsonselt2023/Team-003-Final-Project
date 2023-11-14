class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    @review = Review.new

  end

  def some_action
    @user = User.find_by(id: some_id)
  end

  def add_to_cart
  end

  def message_seller
  end

  def write_review
    @product = Product.find(params[:id])
    @review = @product.reviews.build(review_params)
    @review.user = current_user  # assuming you have a method to get the currently logged-in user

    if @review.save
      flash[:notice] = "Review successfully submitted!"
      redirect_to product_path(@product)
    else
      flash[:alert] = "There was a problem submitting your review."
      render :show
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

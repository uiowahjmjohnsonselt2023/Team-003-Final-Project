class ReviewsController < ApplicationController
  before_action :set_product

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user  # Assumes you have a method to get the current user

    if @review.save
      flash[:notice] = 'Review successfully submitted!'
    else
      flash[:alert] = 'There was a problem submitting your review.'
    end
    redirect_to product_path(@product)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

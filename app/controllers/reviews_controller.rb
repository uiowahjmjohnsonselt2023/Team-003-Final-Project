class ReviewsController < ApplicationController
  before_action :set_product
  before_action :set_review, only: [:destroy]
  before_action :check_user, only: [:destroy]

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params)
    @review.reviewer = current_user
    @review.reviewee_id = @product.owner_id

    if @review.save
      redirect_to product_path(@product), notice: 'Review successfully submitted!'
    else
      render :new, alert: 'There was a problem submitting your review.'
    end
  end

  def destroy
    if @review
      @review.destroy
      redirect_to product_path(@product), notice: 'Review was successfully deleted.'
    else
      redirect_to product_path(@product), alert: 'Review could not be found.'
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_review
    # Use find_by to avoid throwing an exception if the review is not found
    @review = @product.reviews.find_by(id: params[:id])
  end

  def check_user
    unless current_user == @review.user
      redirect_to product_path(@product), alert: 'You do not have permission to delete this review.'
    end
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :product_id)
  end
end
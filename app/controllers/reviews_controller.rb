class ReviewsController < ApplicationController
  before_action :set_product, only: [:create]      # set the product before creating a review
  before_action :set_review, only: [:destroy]      # set the review before destroying it
  before_action :check_user, only: [:destroy]      # check if the current user has permission to delete the review

  # create a new review for a product
  def create
    @review = @product.reviews.build(review_params)
    @review.reviewer = current_user
    @review.reviewee = @product.user

    if @review.valid?
      @review.save
      redirect_to product_path(@product), notice: 'Review successfully submitted!'
    else
      @user = @product.user
      @reviews = @product.reviews.reload
      render 'products/show', alert: 'There was a problem submitting your review: ' + @review.errors.full_messages.to_sentence
    end
  end

  # delete a review for a product
  def destroy
    if @review.destroy
      redirect_to product_path(@product), notice: 'Review was successfully deleted.'
    else
      redirect_to product_path(@product), alert: 'Review could not be found or you do not have permission to delete it.'
    end
  end

  private

  # set the product based on the product_id parameter
  def set_product
    @product = Product.find_by(id: params[:product_id])
    unless @product
      redirect_to root_path, alert: 'Product not found.'
    end
  end

  # set the review based on the id parameter
  def set_review
    @review = @product.reviews.find_by(id: params[:id])
  end

  # check if the current user has permission to delete the review
  def check_user
    redirect_to product_path(@product), alert: 'You do not have permission to delete this review.' unless current_user == @review.reviewer
  end

  # define strong parameters for the review
  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end

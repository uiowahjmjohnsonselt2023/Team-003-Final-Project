class ReviewsController < ApplicationController
  before_action :set_product, only: [:create]
  before_action :set_review, only: [:destroy]
  before_action :check_user, only: [:destroy]

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

  def destroy
    if @review.destroy
      redirect_to product_path(@product), notice: 'Review was successfully deleted.'
    else
      redirect_to product_path(@product), alert: 'Review could not be found or you do not have permission to delete it.'
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:product_id])
    unless @product
      redirect_to root_path, alert: 'Product not found.'
    end
  end

  def set_review
    @review = @product.reviews.find_by(id: params[:id])
  end

  def check_user
    redirect_to product_path(@product), alert: 'You do not have permission to delete this review.' unless current_user == @review.reviewer
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end

class ReviewsController < ApplicationController
  before_action :set_product
  before_action :set_review, only: [:destroy]
  before_action :check_user, only: [:destroy]


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

  def destroy
    if @review.destroy
      flash[:notice] = 'Review successfully deleted!'
    else
      flash[:alert] = 'There was a problem deleting your review.'
    end
    redirect_to product_path(@product)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def check_user
    unless current_user == @review.user
      flash[:alert] = 'You do not have permission to delete this review.'
      redirect_to product_path(@product)
    end
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

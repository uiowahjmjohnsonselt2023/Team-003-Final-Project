class ReviewsController < ApplicationController
  before_action :set_product, only: [:create, :destroy]   # ensures the product is set before creating or destroying a review
  before_action :set_review, only: [:destroy]             # finds the review before attempting to destroy it
  before_action :check_user, only: [:destroy]             # verifies if the current user is authorized to delete the review
  before_action :authenticate_user!                       # ensures that a user is logged in before any review action

  # POST /products/:product_id/reviews
  # creates a new review for a product
  def create
    @review = @product.reviews.build(review_params)
    @review.reviewer = current_user                # sets the current logged-in user as the reviewer
    @review.reviewee = @product.user               # sets the product owner as the reviewee

    if @review.save
      # if the review saves successfully, redirect to the product page with a success message
      redirect_to product_path(@product), notice: 'Review successfully submitted!'
    else
      # if the review fails to save, reload the necessary data for rendering the 'products/show' template
      @user = @product.user
      @reviews = @product.reviews.reload

      # render the 'products/show' template with an alert containing the full error messages
      render 'products/show', alert: 'There was a problem submitting your review: ' + @review.errors.full_messages.to_sentence
    end
  end

  # delete a review for a product
  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      flash[:notice] = 'Review was successfully deleted.'
      redirect_to product_path(@review.product), status: :see_other
    else
      flash[:alert] = 'Review could not be found or you do not have permission to delete it.'
      redirect_to product_path(@review.product), status: :see_other
    end
  end

  private

  # sets the product based on the product_id passed in the parameters
  def set_product
    @product = Product.find_by(id: params[:product_id])
    unless @product
      redirect_to products_path, alert: 'Product not found.'
      return
    end
  end

  # sets the review based on the id passed in the parameters
  def set_review
    @review = Review.find_by(id: params[:id])

    # redirect with an error message if the review is not found
    unless @review
      redirect_to products_path, alert: 'Review not found.'
      return
    end
  end

  # checks if the current_user is authorized to delete the review
  def check_user
    redirect_to root_path, alert: "You don't have permission to do that." unless @review.reviewer == current_user
  end

  # define strong parameters for the review
  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end

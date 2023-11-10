# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  
    def new
      @review = Review.new
    end
  
    def create
      @review = Review.new(review_params)
      if @review.save
        flash[:notice] = "Review was successfully created."
        redirect_to root_path
      else
        flash.now[:alert] = 'Failed to create a review.'
        render :new
      end
    end
  
    private
  
    def review_params
      params.require(:review).permit(:rating, :comment, :reviewer_id, :reviewee_id)
    end
end
  
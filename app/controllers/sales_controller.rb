class SalesController < ApplicationController



    def create_review
        @sale = Sale.find(params[:id])
        @review = @sale.build_review(review_params.merge(user_id: current_user.id))
        
        if @review.save
            flash[:success] = "Review created successfully."
        else
            flash[:error]= "Error creating review."
        end
        redirect_to @sale
    end
    
    private

    def review_params
        params.require(:review).permit(:content, :rating)
    end
end

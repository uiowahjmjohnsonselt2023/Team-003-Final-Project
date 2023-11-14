class FeedbackController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content, :order_id)
  end
end

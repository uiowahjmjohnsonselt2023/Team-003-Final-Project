class FeedbackController < ApplicationController
  before_action :set_order, only: [:new, :create]

  # GET /orders/:order_id/feedback/new
  def new
    @feedback = Feedback.new
  end

  # POST /orders/:order_id/feedback
  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.order = @order
    if @feedback.save
    else
      render :new
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  rescue ActiveRecord::RecordNotFound
  end

  def feedback_params
  end
end


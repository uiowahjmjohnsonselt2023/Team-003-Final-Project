class FeedbackController < ApplicationController
  before_action :set_order, only: [:new, :create]

  # GET /orders/:order_id/feedback/new
  def new
    @feedback = Feedback.new
  end

  # POST /orders/:order_id/feedback
  def create
    if @order.feedback.present?
      @feedback = @order.feedback
      @feedback.assign_attributes(feedback_params)
    else
      @feedback = @order.build_feedback(feedback_params)
    end

    if @feedback.save
      flash[:notice] = "Feedback successfully submitted!"
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Order not found."
    redirect_to root_path
  end

  def feedback_params
    params.require(:feedback).permit(:rating, :comment)
  end
end


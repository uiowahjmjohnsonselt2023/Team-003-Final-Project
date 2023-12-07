class TrackingsController < ApplicationController
  def show
    @order = Order.find(params[:order_id])
    @tracking = @order.tracking

    if @tracking.nil?
      flash[:alert] = "Tracking information not found."
      redirect_to root_path
    end
  end
end

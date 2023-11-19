class TrackingsController < ApplicationController
  def show
    @order = Order.find_by(id: params[:order_id])
    @tracking = @order.tracking if @order.present?

    unless @tracking
      flash[:alert] = "Tracking information not found."
      redirect_to root_path and return
    end
  end
end


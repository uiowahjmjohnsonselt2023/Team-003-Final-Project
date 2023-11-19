class TrackingController < ApplicationController
  def show
    @order = Order.find(params[:order_id])
    @tracking = @order.tracking
  end
end

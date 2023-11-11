class OrdersController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to @order, notice: 'Order was successfully placed.'
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end
  private

  def order_params
    params.require(:order).permit(:user_id, :product_id, :quantity, :status)
  end
end


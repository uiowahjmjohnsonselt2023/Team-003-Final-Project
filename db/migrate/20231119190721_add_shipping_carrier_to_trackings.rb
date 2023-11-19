class AddShippingCarrierToTrackings < ActiveRecord::Migration[7.1]
  def change
    add_column :trackings, :shipping_carrier, :string
  end

  @tracking = @order.create_tracking(
    tracking_number: SecureRandom.uuid,
    status: :processing,
    shipping_carrier: 'UPS' # Example carrier
  )

end

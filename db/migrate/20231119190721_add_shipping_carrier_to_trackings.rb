class AddShippingCarrierToTrackings < ActiveRecord::Migration[7.1]
  def change
    add_column :trackings, :shipping_carrier, :string
  end
end

class AddShippingCarrierToTrackings < ActiveRecord::Migration[7.1]
  def up
    unless column_exists?(:trackings, :shipping_carrier)
      add_column :trackings, :shipping_carrier, :string
    end
  end

  def down
    remove_column :trackings, :shipping_carrier if column_exists?(:trackings, :shipping_carrier)
  end
end
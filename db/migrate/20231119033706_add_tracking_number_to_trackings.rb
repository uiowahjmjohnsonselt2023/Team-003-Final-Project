class AddTrackingNumberToTrackings < ActiveRecord::Migration[7.1]
  def change
    add_column :trackings, :tracking_number, :string
  end
end

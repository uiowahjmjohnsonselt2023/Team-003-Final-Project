class AddOrderIdToTrackings < ActiveRecord::Migration[7.1]
  def change
    add_reference :trackings, :order, null: false, foreign_key: true
  end
end

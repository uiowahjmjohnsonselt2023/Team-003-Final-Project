class AddBidToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :bid, :decimal
  end
end

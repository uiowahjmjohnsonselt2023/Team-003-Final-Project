class AddStartingBidToProducts < ActiveRecord::Migration[7.1]
  def change
      add_column :products, :starting_bid, :decimal

  end
end

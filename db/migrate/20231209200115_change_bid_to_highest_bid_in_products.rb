class ChangeBidToHighestBidInProducts < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :bid, :highest_bid
  end
end

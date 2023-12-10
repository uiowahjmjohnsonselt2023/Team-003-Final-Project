class AddAuctionTimesToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :auction_start_time, :datetime
    add_column :products, :auction_end_time, :datetime
  end
end

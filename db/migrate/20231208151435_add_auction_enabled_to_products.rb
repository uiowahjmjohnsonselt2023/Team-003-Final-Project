class AddAuctionEnabledToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :auction_enabled, :boolean
  end
end

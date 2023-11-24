class AddBuyNowPriceToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :buy_now_price, :decimal, precision: 10, scale: 2
  end
end

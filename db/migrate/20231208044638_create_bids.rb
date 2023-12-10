class CreateBids < ActiveRecord::Migration[7.1]
  def change
    create_table :bids do |t|
      t.bigint :user_id, null: false
      t.bigint :product_id, null: false
      t.decimal :amount, null: false, precision: 10, scale: 2

      t.timestamps
    end

    add_foreign_key :bids, :users
    add_foreign_key :bids, :products
  end
end

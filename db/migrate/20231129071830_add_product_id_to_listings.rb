class AddProductIdToListings < ActiveRecord::Migration[7.1]
  def change
    add_reference :listings, :product, null: false, foreign_key: true
  end
end

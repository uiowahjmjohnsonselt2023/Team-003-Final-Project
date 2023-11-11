class AddProductToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :product_id, :integer
    add_foreign_key :reviews, :products
  end
end

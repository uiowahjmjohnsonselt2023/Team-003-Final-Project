class AddCategoryIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :category, foreign_key: true, null: true
  end
end
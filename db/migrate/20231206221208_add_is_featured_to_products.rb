class AddIsFeaturedToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :is_featured, :boolean
  end
end

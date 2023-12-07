class AddIsPromotedToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :is_promoted, :boolean
  end
end

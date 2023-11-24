class AddBestSellingAndFeaturedToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :sales_count, :integer, default: 0
    add_column :products, :featured, :boolean, default: false
  end
end

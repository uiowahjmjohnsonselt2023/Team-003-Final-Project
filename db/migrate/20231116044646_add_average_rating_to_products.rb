class AddAverageRatingToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :average_rating, :float, default: 0.0
  end
end
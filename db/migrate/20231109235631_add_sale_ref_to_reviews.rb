class AddSaleRefToReviews < ActiveRecord::Migration[7.1]
  def change
    add_reference :reviews, :sale, null: false, foreign_key: true
  end
end

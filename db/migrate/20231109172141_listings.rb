class Listings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :price
      t.string :condition
      t.string :quantity
      t.string :images
      t.timestamps
    end
  end
end

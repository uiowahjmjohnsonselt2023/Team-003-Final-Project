class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.string :condition
      t.string :location
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end

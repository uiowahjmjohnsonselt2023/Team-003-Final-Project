class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :id, index: true
      t.timestamps
    end
  end
end

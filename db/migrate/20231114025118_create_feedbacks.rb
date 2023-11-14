class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end

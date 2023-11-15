class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    # create_table :reviews do |t|
    #   t.integer :rating
    #   t.references :reviewer, null: false
    #   t.references :reviewee, null: false
    #   t.timestamps
    # end
    # add_foreign_key :reviews, :users, column: :reviewer_id
    # add_foreign_key :reviews, :users, column: :reviewee_id
  end
end

class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    # check if the 'reviews' table doesn't exist before creating it to prevent duplicate table errors.
    unless table_exists?(:reviews)
      create_table :reviews do |t|
        t.integer :rating      # stores the review rating
        t.string :comment      # stores review comment

        # act as foreign keys to link reviews to the users who wrote them and users who received them.
        t.references :reviewer, null: false, foreign_key: { to_table: :users }
        t.references :reviewee, null: false, foreign_key: { to_table: :users }
        t.references :product, null: false, foreign_key: true

        t.timestamps
      end
    end

    # if 'reviews' table exists but is missing the 'comment' column, add it.
    unless column_exists?(:reviews, :comment)
      add_column :reviews, :comment, :string
    end

    # if 'reviews' table exists but is missing the 'product_id' column, add it.
    unless column_exists?(:reviews, :product_id)
      add_reference :reviews, :product, null: false, foreign_key: true
    end
  end
end



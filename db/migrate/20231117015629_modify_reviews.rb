class ModifyReviews < ActiveRecord::Migration[6.0]
  def change

    # remove the 'content' column if it is not needed
    remove_column :reviews, :content, :text if column_exists?(:reviews, :content)

    # remove the 'user_id' column if it is not needed
    remove_column :reviews, :user_id, :bigint if column_exists?(:reviews, :user_id)

    # add foreign key constraints
    unless foreign_key_exists?(:reviews, :users, column: :reviewer_id)
      add_foreign_key :reviews, :users, column: :reviewer_id
    end
    unless foreign_key_exists?(:reviews, :users, column: :reviewee_id)
      add_foreign_key :reviews, :users, column: :reviewee_id
    end
    unless foreign_key_exists?(:reviews, :products, column: :product_id)
      add_foreign_key :reviews, :products, column: :product_id
    end

    # add indexes
    add_index :reviews, :reviewer_id unless index_exists?(:reviews, :reviewer_id)
    add_index :reviews, :reviewee_id unless index_exists?(:reviews, :reviewee_id)
  end
end

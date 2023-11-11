class RemoveUserIdFromReviews < ActiveRecord::Migration[7.1]
  def change
    remove_column :reviews, :user_id, :bigint
  end
end

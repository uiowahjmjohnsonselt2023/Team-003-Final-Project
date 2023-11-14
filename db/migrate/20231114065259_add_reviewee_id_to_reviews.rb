class AddRevieweeIdToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :reviewee_id, :bigint
  end
end

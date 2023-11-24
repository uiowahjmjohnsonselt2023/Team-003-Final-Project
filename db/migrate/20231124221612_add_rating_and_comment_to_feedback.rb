class AddRatingAndCommentToFeedback < ActiveRecord::Migration[7.1]
  def change
    add_column :feedbacks, :rating, :integer
    add_column :feedbacks, :comment, :text
  end
end
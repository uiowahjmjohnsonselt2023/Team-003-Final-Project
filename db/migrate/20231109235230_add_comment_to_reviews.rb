class AddCommentToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :comment, :string
  end
end

class AddResetDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :reset_digest, :string
  end
end

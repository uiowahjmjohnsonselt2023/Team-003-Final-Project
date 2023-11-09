class CreatePasswordResets < ActiveRecord::Migration[6.0]
  def change
    create_table :password_resets do |t|
      t.references :user, foreign_key: true
      t.string :token
      t.timestamps
    end
  end
end

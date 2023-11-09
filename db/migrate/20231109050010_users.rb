# This migration creates the 'users' table with columns for user information.
# - 'name'             = stores the user's name.
# - 'username'         = stores the user's chosen username.
# - 'email'            = stores the user's email address.
# - 'password_digest'  = stores the user's password securely using bcrypt.
# - 'bio'              = stores additional user information in text format.
# - 'timestamps'       = adds 'created_at' and 'updated_at' columns for tracking record creation and updates
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.text :bio

      t.timestamps
    end
  end
end

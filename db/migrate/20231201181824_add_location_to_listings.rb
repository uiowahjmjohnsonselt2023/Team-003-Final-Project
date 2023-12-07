class AddLocationToListings < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :location, :string
  end
end

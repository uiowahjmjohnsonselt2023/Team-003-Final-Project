class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.integer :id, index: true
      t.timestamps
    end
  end
end

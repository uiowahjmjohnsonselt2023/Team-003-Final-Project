class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.timestamps
    end
  end
end

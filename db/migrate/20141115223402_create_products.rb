class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :order_id
      t.integer :restaurant_id

      t.timestamps
    end
  end
end

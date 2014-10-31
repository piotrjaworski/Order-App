class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :short_info
      t.decimal :price
      t.integer :user_id
      t.string :restaurant

      t.timestamps
    end
  end
end

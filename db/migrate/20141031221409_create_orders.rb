class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text    :short_info
      t.integer :user_id
      t.string  :restaurant_id
      t.boolean :ordered

      t.timestamps
    end
  end
end

class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.integer :user_id
      t.integer :delivery_time

      t.timestamps
    end
  end
end

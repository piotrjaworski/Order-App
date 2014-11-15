class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :short_info
      t.string :type

      t.timestamps
    end
  end
end

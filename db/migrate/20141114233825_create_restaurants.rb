class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :short_info
      t.string :restaurant_type
      t.string :address
      t.float  :latitude
      t.float  :longitude

      t.timestamps
    end
  end
end

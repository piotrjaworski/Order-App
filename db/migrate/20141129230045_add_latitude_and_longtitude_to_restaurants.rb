class AddLatitudeAndLongtitudeToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :latitude, :float
    add_column :restaurants, :longtitude, :float
  end
end

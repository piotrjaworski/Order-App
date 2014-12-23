class AddRestaurantIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :restaurant_id, :integer
  end
end

class RemoveRestaurantFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :restaurant, :string
  end
end

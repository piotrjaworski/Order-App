class RemovePriceFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :price, :decimal
  end
end

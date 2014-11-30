class AddOrderedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ordered, :boolean
  end
end

class RenameTypeToRestaurantTypeInRestaraunts < ActiveRecord::Migration
  def change
    rename_column :restaurants, :type, :restaurant_type
  end
end

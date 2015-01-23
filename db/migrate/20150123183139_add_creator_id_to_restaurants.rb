class AddCreatorIdToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :creator_id, :integer
  end
end

class AddAddressAndLogoToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :address, :string
    add_column :restaurants, :logo, :string
  end
end

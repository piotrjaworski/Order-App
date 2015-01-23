class CreateRestaurantsUsers < ActiveRecord::Migration
  def change
    create_table :restaurants_users do |t|
      t.belongs_to :restaurant, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end

class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.decimal :score
      t.references :user, index: true
      t.references :restaurant, index: true
      t.references :product, index: true
      t.text :comment

      t.timestamps
    end
  end
end

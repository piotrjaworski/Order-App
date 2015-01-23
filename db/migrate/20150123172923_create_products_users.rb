class CreateProductsUsers < ActiveRecord::Migration
  def change
    create_table :products_users do |t|
      t.belongs_to :product, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end

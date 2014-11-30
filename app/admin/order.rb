ActiveAdmin.register Order do
  scope :ordered

  index do
    selectable_column
    column :id
    column "Products" do |order|
     raw (order.products.map { |product| (link_to product.name, admin_product_path(product)) }.join(', '))
    end
    column :short_info
    column :user
    column :restaurant
    column :ordered
    column :created_at
    column :updated_at
    actions
  end
end

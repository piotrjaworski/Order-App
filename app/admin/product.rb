ActiveAdmin.register Product do

  index do
    selectable_column
    column :id
    column :name
    column :price
    column :order
    column "Ordered at", :created_at
    actions
  end
end

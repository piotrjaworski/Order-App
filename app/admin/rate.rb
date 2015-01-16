ActiveAdmin.register Rate do

  index do
    selectable_column
    column :id
    column :score
    column :user
    column :restaurant
    column :product
    column :comment
    column "Rated at", :created_at
    actions
  end


end

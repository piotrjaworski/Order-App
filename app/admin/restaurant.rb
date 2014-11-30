ActiveAdmin.register Restaurant do

  index do
    selectable_column
    column :id
    column :user
    column :name
    column :short_info
    column :restaurant_type
    column :address
    column :created_at
    column :updated_at
    actions
  end
end

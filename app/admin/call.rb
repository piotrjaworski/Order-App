ActiveAdmin.register Call do

  index do
    selectable_column
    column :id
    column :user
    column :created_at
    column :updated_at
    actions
  end
end

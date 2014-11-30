ActiveAdmin.register User do

  index do
    selectable_column
    column :id
    column :name
    column :email
    column "Joined", :created_at
    column :last_sign_in_ip
    column :last_sign_in_at
    column :sign_in_count
    actions
  end
end

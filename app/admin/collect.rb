ActiveAdmin.register Collect do

  index do
    selectable_column
    column :id
    column :user
    column :created_at
    column :updated_at
    actions
  end

  #permit_params :id, :user, :created_at, :updated_at

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end

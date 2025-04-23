ActiveAdmin.register Category do
  permit_params :name

  # optional filters and display
  filter :name

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end
end

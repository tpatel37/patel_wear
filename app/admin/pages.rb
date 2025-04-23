ActiveAdmin.register Page do
  permit_params :title, :body

  form do |f|
    f.inputs 'Page Content' do
      f.input :title
      f.input :body, as: :text
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  show do
    attributes_table do
      row :title
      row :body
    end
  end
end

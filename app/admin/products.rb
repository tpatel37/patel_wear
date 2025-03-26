ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :category_id, :image

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

  show do |product|
    attributes_table do
      row :name
      row :description
      row :price
      row :stock
      row :category
      row :image do |img|
        image_tag img.image, width: 100 if img.image.attached?
      end
    end
  end
end

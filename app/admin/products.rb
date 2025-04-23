ActiveAdmin.register Product do
 
  config.filters = true
  filter :name
  filter :price
  filter :stock
  filter :category
  

  
  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock
      row :category
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), size: "300x300"
        else
          status_tag("No Image", class: "warning")
        end
      end
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end


  index do
    selectable_column
    id_column
    column :name
    column :price
    column :stock
    column :category
    column "Image" do |product|
      if product.image.attached?
        image_tag url_for(product.image), size: "100x100"
      else
        status_tag("No Image", class: "warning")
      end
    end
    actions
  end

  
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

  
  permit_params :name, :description, :price, :stock, :category_id, :image
end

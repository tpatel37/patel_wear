ActiveAdmin.register Order do
    permit_params :status, :total, :customer_id, :province_id, :address, :gst, :pst, :hst
  
    index do
      selectable_column
      id_column
      column :customer
      column :status
      column :total
      column :created_at
      actions
    end
  
    filter :customer
    filter :status
    filter :created_at
  
    form do |f|
      f.inputs do
        f.input :customer
        f.input :province
        f.input :status, as: :select, collection: Order.statuses.keys
        f.input :total
      end
      f.actions
    end
  
    show do
      attributes_table do
        row :id
        row :customer
        row :status
        row :total
        row :address
        row :created_at
        row :updated_at
      end
    end
  end
  
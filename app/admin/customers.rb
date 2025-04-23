ActiveAdmin.register Customer do
  permit_params :name, :email, :address, :province_id

  # ✅ Define filters explicitly (no password fields)
  filter :id
  filter :name
  filter :email
  filter :address
  filter :province
  filter :created_at

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address
    column :province
    column "Total Spent" do |customer|
      number_to_currency customer.orders.map(&:total).compact.sum

    end
    actions
  end
end

class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.text :address
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end

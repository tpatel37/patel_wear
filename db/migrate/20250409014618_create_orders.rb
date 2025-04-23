class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.references :province, null: false, foreign_key: true
      t.decimal :total

      t.timestamps
    end
  end
end

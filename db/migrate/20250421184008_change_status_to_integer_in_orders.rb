class ChangeStatusToIntegerInOrders < ActiveRecord::Migration[7.0]
  def up
    # 1. Rename old string column temporarily
    rename_column :orders, :status, :status_old

    # 2. Add new integer column with the same name
    add_column :orders, :status, :integer, default: 0

    # 3. Copy over values (handle nils as pending)
    execute <<-SQL
      UPDATE orders SET status =
        CASE status_old
          WHEN 'pending' THEN 0
          WHEN 'paid' THEN 1
          WHEN 'shipped' THEN 2
          ELSE 0
        END
    SQL

    # 4. Remove the old column
    remove_column :orders, :status_old
  end

  def down
    add_column :orders, :status_old, :string

    execute <<-SQL
      UPDATE orders SET status_old =
        CASE status
          WHEN 0 THEN 'pending'
          WHEN 1 THEN 'paid'
          WHEN 2 THEN 'shipped'
          ELSE NULL
        END
    SQL

    remove_column :orders, :status
    rename_column :orders, :status_old, :status
  end
end

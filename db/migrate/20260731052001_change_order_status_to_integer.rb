class ChangeOrderStatusToInteger < ActiveRecord::Migration[8.1]
  def up
    remove_column :orders, :status

    add_column :orders,
               :status,
               :integer,
               default: 0,
               null: false
  end

  def down
    remove_column :orders, :status

    add_column :orders,
               :status,
               :string
  end
end
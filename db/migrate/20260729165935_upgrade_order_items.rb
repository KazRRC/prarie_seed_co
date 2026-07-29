class UpgradeOrderItems < ActiveRecord::Migration[8.1]
  def change
    add_column :order_items, :product_name, :string
    add_column :order_items, :unit_price, :decimal,
               precision: 10,
               scale: 2

    add_column :order_items, :line_total, :decimal,
               precision: 10,
               scale: 2
  end
end
class UpgradeOrders < ActiveRecord::Migration[8.1]
  def change
    change_table :orders do |t|
      t.decimal :subtotal, precision: 10, scale: 2

      t.decimal :gst_rate, precision: 5, scale: 2
      t.decimal :pst_rate, precision: 5, scale: 2
      t.decimal :hst_rate, precision: 5, scale: 2

      t.decimal :gst_amount, precision: 10, scale: 2
      t.decimal :pst_amount, precision: 10, scale: 2
      t.decimal :hst_amount, precision: 10, scale: 2

      t.string :payment_id
    end
  end
end
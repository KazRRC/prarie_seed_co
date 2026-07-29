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

      t.string :first_name
      t.string :last_name
      t.string :phone_number

      t.string :street_address
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :country
    end
  end
end
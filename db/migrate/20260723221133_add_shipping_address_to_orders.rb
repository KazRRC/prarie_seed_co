class AddShippingAddressToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :phone_number, :string
    add_column :orders, :street_address, :string
    add_column :orders, :city, :string
    add_column :orders, :province, :string
    add_column :orders, :postal_code, :string
    add_column :orders, :country, :string
  end
end

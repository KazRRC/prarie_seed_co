class AddAddressToCustomers < ActiveRecord::Migration[8.1]
  def change
    add_column :customers, :street_address, :string
    add_column :customers, :city, :string
    add_column :customers, :province, :string
    add_column :customers, :postal_code, :string
    add_column :customers, :country, :string
  end
end

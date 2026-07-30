class AddProvinceReferenceToCustomers < ActiveRecord::Migration[8.1]
  def change
    add_reference :customers, :province, foreign_key: true

    remove_column :customers, :province, :string
  end
end
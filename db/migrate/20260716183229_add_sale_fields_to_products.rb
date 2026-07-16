class AddSaleFieldsToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :on_sale, :boolean, default: false
    add_column :products, :sale_price, :decimal
  end
end
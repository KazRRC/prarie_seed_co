class AddPaymentIdToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :payment_id, :string
    add_column :orders, :paid_at, :datetime
  end
end

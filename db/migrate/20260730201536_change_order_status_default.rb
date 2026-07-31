class ChangeOrderStatusDefault < ActiveRecord::Migration[8.1]
  def change
    change_column_default :orders, :status, from: nil, to: "new"
  end
end
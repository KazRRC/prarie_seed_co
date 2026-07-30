ActiveAdmin.register Order do
  menu priority: 3

  permit_params :status

  filter :status
  filter :customer

  index do
    selectable_column
    id_column

    column :customer
    column :status
    column :subtotal
    column :total
    column :created_at

    actions
  end

  show do
    attributes_table do
      row :customer
      row :status
      row :subtotal
      row :gst_amount
      row :pst_amount
      row :hst_amount
      row :total
      row :payment_id
    end

    panel "Items" do
      table_for order.order_items do
        column :product_name
        column :quantity
        column :unit_price
        column :line_total
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :status,
              as: :select,
              collection: %w[new paid shipped]
    end

    f.actions
  end
end
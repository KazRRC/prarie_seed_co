ActiveAdmin.register Order do
  permit_params :status

  filter :status
  filter :customer
  filter :created_at

  index do
    selectable_column
    id_column

    column :customer
    column :status
    column :subtotal
    column :total
    column :payment_id
    column :created_at

    actions
  end

  show do
    attributes_table do
      row :customer
      row :status
      row :payment_id
      row :subtotal
      row :gst_amount
      row :pst_amount
      row :hst_amount
      row :total

      row :first_name
      row :last_name
      row :street_address
      row :city
      row :province
      row :postal_code
      row :country
    end

    panel "Items Purchased" do
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
              collection: [
                "new",
                "paid",
                "shipped"
              ]
    end

    f.actions
  end
end
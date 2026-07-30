ActiveAdmin.register Customer do
  permit_params :email,
                :first_name,
                :last_name,
                :phone_number,
                :street_address,
                :city,
                :province_id,
                :postal_code,
                :country,
                :admin

  filter :email
  filter :first_name
  filter :last_name
  filter :admin

  index do
    selectable_column
    id_column

    column :first_name
    column :last_name
    column :email
    column :phone_number
    column :province
    column :admin

    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone_number
      f.input :street_address
      f.input :city

      f.input :province,
              as: :select,
              collection: Province.order(:name)

      f.input :postal_code
      f.input :country
      f.input :admin
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :phone_number
      row :street_address
      row :city
      row :province
      row :postal_code
      row :country
      row :admin
      row :created_at
    end
  end
end
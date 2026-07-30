ActiveAdmin.register Province do

  permit_params :name,
                :code,
                :gst_rate,
                :pst_rate,
                :hst_rate

  index do
    selectable_column

    id_column

    column :name
    column :code

    column :gst_rate
    column :pst_rate
    column :hst_rate

    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :code

      f.input :gst_rate
      f.input :pst_rate
      f.input :hst_rate
    end

    f.actions
  end
end
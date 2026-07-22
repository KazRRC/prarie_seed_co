class AddPlantingInfoToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :planting_depth, :string
    add_column :products, :row_spacing, :string
    add_column :products, :plant_spacing, :string
    add_column :products, :sun_requirements, :string
    add_column :products, :days_to_germination, :string

    add_column :products, :featured, :boolean, default: false
  end
end
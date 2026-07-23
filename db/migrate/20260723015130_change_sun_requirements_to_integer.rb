class ChangeSunRequirementsToInteger < ActiveRecord::Migration[8.1]
  def up
    remove_column :products, :sun_requirements
    add_column :products, :sun_requirements,
               :integer,
               default: 0,
               null: false
  end

  def down
    remove_column :products, :sun_requirements
    add_column :products, :sun_requirements, :string
  end
end
class Product < ApplicationRecord
  belongs_to :category
has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true

  validates :price,
            presence: true,
            numericality: {
              greater_than: 0
            }

  validates :stock_quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }
              validates :planting_depth, presence: true
  validates :row_spacing, presence: true
  validates :plant_spacing, presence: true
  validates :sun_requirements, presence: true
  validates :days_to_germination, presence: true
validates :sale_price,
          numericality: {
            greater_than: 0
          },
          allow_nil: true

  enum :sun_requirements,
{
  full_sun: 0,
  partial_sun: 1,
  shade: 2
}
scope :new_products,
  -> {
    order(created_at: :desc)
  }
      scope :on_sale,
      -> { where(on_sale: true) }
end
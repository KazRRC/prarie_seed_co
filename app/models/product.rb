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
validates :sale_price,
          numericality: {
            greater_than: 0
          },
          allow_nil: true
  validates :image_url, presence: true
  scope :new_products,
      -> {
        where(created_at: 3.days.ago..Time.current)
      }
      scope :on_sale,
      -> { where(on_sale: true) }
end
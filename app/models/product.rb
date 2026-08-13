class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 255 }

  validates :description,
            presence: true

  validates :price,
            presence: true,
            numericality: { greater_than: 0 }

  validates :sale_price,
            numericality: {
              greater_than: 0
            },
            allow_nil: true

  validates :stock_quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates :planting_depth,
            presence: true

  validates :row_spacing,
            presence: true

  validates :plant_spacing,
            presence: true

  validates :days_to_germination,
            presence: true

  validates :sun_requirements,
            presence: true

  validates :category,
            presence: true

  validates :featured,
            inclusion: { in: [true, false] }

  validates :on_sale,
            inclusion: { in: [true, false] }

  validate :sale_price_cannot_exceed_regular_price

  scope :new_products,
        -> {
          where("created_at >= ?", 5.days.ago)
            .order(created_at: :desc)
        }

  scope :on_sale,
        -> {
          where(on_sale: true)
            .order(:name)
        }

  def discount_percentage
    return 0 unless on_sale? && sale_price.present? && price.present?

    (((price - sale_price) / price) * 100).round
  end

  private

  def sale_price_cannot_exceed_regular_price
    return if sale_price.blank? || price.blank?

    if sale_price >= price
      errors.add(:sale_price, "must be less than the regular price")
    end
  end
end
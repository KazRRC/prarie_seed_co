class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_items, dependent: :destroy

  validates :total,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  enum :status, {
    pending: 0,
    paid: 1,
    shipped: 2
  }

  validates :status, presence: true
end
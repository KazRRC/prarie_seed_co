class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_items, dependent: :destroy

  validates :total,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :status,
            presence: true

  enum :status,
       {
         pending: "pending",
         completed: "completed",
         cancelled: "cancelled"
       }
end
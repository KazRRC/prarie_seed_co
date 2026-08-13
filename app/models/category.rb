class Category < ApplicationRecord
  has_many :products,
           dependent: :restrict_with_error

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 100 },
            uniqueness: true

  validates :description,
            presence: true
end
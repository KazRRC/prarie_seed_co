class Customer < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, length: { minimum: 10 }
end
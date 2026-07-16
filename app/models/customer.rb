class Customer < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :phone_number,
            presence: true,
            length: { minimum: 10 }

  validates :email,
            presence: true

end
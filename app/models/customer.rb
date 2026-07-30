class Customer < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, presence: true, length: { minimum: 10 }
  has_many :orders, dependent: :destroy
  belongs_to :province, optional: true

validates :street_address,
          presence: true

validates :city,
          presence: true

validates :province,
          presence: true

validates :postal_code,
          presence: true

validates :country,
          presence: true
end
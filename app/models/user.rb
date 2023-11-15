class User < ApplicationRecord
  has_secure_password

  # associations for reviews
  has_many :given_reviews, foreign_key: 'reviewer_id', class_name: 'Review', dependent: :destroy
  has_many :received_reviews, foreign_key: 'reviewee_id', class_name: 'Review', dependent: :destroy

  # validation for user attributes
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  # association for user profile picture
  has_one_attached :profile_picture

  # associations for cart and products
  has_one :cart
  has_many :cart_items, through: :cart
  has_many :products
  has_many :orders
end


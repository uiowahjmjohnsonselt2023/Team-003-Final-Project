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

  has_many :favorites
  has_many :favorite_products, through: :favorites, source: :product

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
             BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # verify a user
  def verify!
    update(verified: true)
  end

  # unverify a user
  def unverify!
    update(verified: false)
  end
end


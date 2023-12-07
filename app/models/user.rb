class User < ApplicationRecord
  # associations for reviews
  has_many :given_reviews, foreign_key: 'reviewer_id', class_name: 'Review', dependent: :destroy
  has_many :received_reviews, foreign_key: 'reviewee_id', class_name: 'Review', dependent: :destroy

  # validation for user attributes
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  # associations for sending and receiving messages
  has_many :sent_messages, foreign_key: 'sender_id', class_name: 'Message', dependent: :destroy
  has_many :received_messages, foreign_key: 'receiver_id', class_name: 'Message', dependent: :destroy

  # association for user profile picture
  has_one_attached :profile_picture
  attribute :verified, :boolean, default: false
  attribute :verification_token, :string

  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy

  # associations for cart and products
  has_one :cart
  has_many :cart_items, through: :cart
  has_many :products

  has_many :reviews, dependent: :destroy
  def verify_account(token)
    return false if verified?

    if token == verification_token
      update(verified: true, verification_token: nil)
      true
    else
      false
    end
  end
  has_many :orders

  # associations for listings
  has_many :listings

  # associations for feedbacks from buyers after purchasing an order
  has_many :feedbacks, through: :orders

  # associations for a user's favorites
  has_many :favorites
  has_many :favorite_products, through: :favorites, source: :product

  # allows for secure password management within the model by adding methods to set and authenticate against a BCrypt password
  has_secure_password

  # allows use of :reset_token as a virtual attribute, which is not saved to the database but can be used like any other attribute of the model
  attr_accessor :reset_token

  # generates a token for password reset, hashes it using BCrypt and saves the digest and the timestamp of when the reset was sent to the database
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # triggers the password reset email to be sent to the user
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # generates a random token using SecureRandom library, suitable for use in URLs and headers for password reset
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # returns a hash digest of the given string, using BCrypt hashing algorithm
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
             BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # calculates the average rating of received reviews
  def average_rating
    received_reviews.average(:rating).to_f
  end
end



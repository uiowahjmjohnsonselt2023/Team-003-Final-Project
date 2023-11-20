# User Model
# --------------------
# attributes:
# - name (String)              = user's full name (or even just their first name)
# - username (String)          = user's unique username
# - email (String)             = user's email address
# - password_digest (String)   = stores the encrypted password
# - bio (Text):                = text field for the user's bio or description
#
# validations:
# - username   = presence and case-insensitive uniqueness
# - email      = presence, uniqueness, and valid email format
# - password   = presence and a minimum length of 6 characters
#
# associations:
# - profile_picture (ActiveStorage) = stores the user's profile picture.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_secure_password
  has_many :given_reviews, foreign_key: 'reviewer_id', class_name: 'Review'
  has_many :received_reviews, foreign_key: 'reviewee_id', class_name: 'Review'
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  has_one_attached :profile_picture

  has_one :cart
  has_many :products
  has_many :reviews, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email.downcase
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
    end

  end




end


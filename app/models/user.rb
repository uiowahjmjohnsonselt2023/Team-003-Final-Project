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
  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  has_one_attached :profile_picture

  has_one :cart
  has_many :reviews, dependent: :destroy

end


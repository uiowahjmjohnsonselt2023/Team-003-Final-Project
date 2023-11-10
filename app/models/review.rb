class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user, presence: true
end

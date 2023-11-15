class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :orders

  has_many :favorites
  has_many :favorited_by, through: :favorites, source: :user

end

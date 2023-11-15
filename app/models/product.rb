class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :orders
end

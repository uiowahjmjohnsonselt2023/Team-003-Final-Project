class Product < ApplicationRecord
  belongs_to :user, :owner, class_name: 'User', foreign_key: 'user_id'
  has_one_attached :image
  has_many :reviews, dependent: :destroy
end

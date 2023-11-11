class Product < ApplicationRecord
  alias_attribute :owner, :user
  belongs_to :user, class_name: 'User', foreign_key: 'owner_id'
  has_one_attached :image
  has_many :reviews, dependent: :destroy
end

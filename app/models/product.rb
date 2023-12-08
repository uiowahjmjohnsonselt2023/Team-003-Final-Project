class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :orders

  has_many :favorites
  has_many :favorited_by, through: :favorites, source: :user

  has_many :conversations
  has_many :bids, dependent: :destroy

  def current_highest_bid
    bids.maximum(:amount)
  end
  def self.search(query)
    where('title LIKE :query OR description LIKE :query', query: "%#{query}%")
  end

  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :by_condition, ->(condition) { where(condition: condition) if condition.present? }
  
  scope :best_selling, -> { order(sales_count: :desc) }
  scope :featured, -> { where(featured: true) }
end

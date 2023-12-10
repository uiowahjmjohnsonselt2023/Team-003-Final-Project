class Product < ApplicationRecord
  belongs_to :user
  has_many :listings
  belongs_to :category

  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_items, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user, dependent: :destroy

  has_many :conversations, dependent: :destroy

  def self.search(query)
    where('title LIKE :query OR description LIKE :query', query: "%#{query}%")
  end

  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :by_condition, ->(condition) { where(condition: condition) if condition.present? }
  
  scope :best_selling, -> { order(sales_count: :desc) }

  scope :featured, -> {
    joins(:order_items)
      .select('products.*, COUNT(order_items.id) AS orders_count')
      .group('products.id')
      .order('orders_count DESC')
      .limit(5)
  }
end

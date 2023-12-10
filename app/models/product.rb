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
  
  has_many :bids, dependent: :destroy

  validates :auction_enabled, inclusion: [true, false]
  validates :starting_bid, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :highest_bid, presence: true, numericality: { greater_than_or_equal_to: 0 }
  with_options if: :auction_enabled? do |auction_product|
   auction_product.validates :auction_start_time, presence: true
   auction_product.validates :auction_end_time, presence: true
  end
  def highest_bid
    bids.maximum(:amount) || starting_bid
  end
  def highest_bidder
    highest_bid = bids.order(amount: :desc).first
    highest_bid&.user
  end

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

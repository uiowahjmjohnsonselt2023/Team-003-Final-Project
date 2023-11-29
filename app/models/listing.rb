class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :condition, presence: true
  validates :quantity, presence: true
  validates :images, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
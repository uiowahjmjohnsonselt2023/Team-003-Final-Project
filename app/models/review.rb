class Review < ApplicationRecord
    belongs_to :reviewer, class_name: 'User'
    belongs_to :reviewee, class_name: 'User'

    belongs_to :product

    validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    validates :comment, presence: true, length: { maximum: 2500 }
end


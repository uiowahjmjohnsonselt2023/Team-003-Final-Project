class Review < ApplicationRecord
    belongs_to :reviewee, class_name: 'User', foreign_key: 'reviewee_id'
    belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id'

    belongs_to :product

    validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    validates :comment, presence: true, length: { maximum: 2500 }
end


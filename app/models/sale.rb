class Sale < ApplicationRecord
    has_one :review, dependent: :destroy
end

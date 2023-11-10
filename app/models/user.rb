class User < ApplicationRecord
    has_many :reviews, dependent: :destroy
end

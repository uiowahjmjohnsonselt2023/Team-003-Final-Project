FactoryBot.define do
  factory :review do
    association :user
    association :product
    rating { rand(1..5) }
    content { "This is review content." }
  end
end
FactoryBot.define do
  factory :review do
    comment { "Great buyer!" }
    rating { 5 }
    association :reviewer, factory: :user
    association :reviewee, factory: :user
    product
  end
end
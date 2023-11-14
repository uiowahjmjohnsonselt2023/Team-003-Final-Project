FactoryBot.define do
  factory :product do
    title { "Example Product" }
    description { "This is an example product description." }
    price { 19.99 }
    association :owner, factory: :user
  end
end
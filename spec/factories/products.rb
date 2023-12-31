FactoryBot.define do
  factory :product do
    title { "Example Product" }
    description { "This is an example product description." }
    price { 19.99 }
    user
    category { Category.first || FactoryBot.create(:category) }
  end
end
FactoryBot.define do
  factory :review do
    user { nil }
    product { nil }
    content { "MyText" }
    rating { 1 }
  end
end

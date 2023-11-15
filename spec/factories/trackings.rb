FactoryBot.define do
  factory :tracking do
    sequence(:tracking_number) { |n| "TRACK#{n}" }
  end
end
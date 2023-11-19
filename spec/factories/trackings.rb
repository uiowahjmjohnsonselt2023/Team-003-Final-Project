FactoryBot.define do
  factory :tracking do
    tracking_number { SecureRandom.uuid }
    status { :processing }
    shipping_carrier { "UPS" }
    order
  end
end
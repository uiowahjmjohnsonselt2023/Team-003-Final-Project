FactoryBot.define do
  factory :order do
    association :user
    street { "123 Example St" }
    city { "Anytown" }
    postal_code { "12345" }
    credit_card_number { "1234567890123456" }
    expiration_date { "01/23" }
    cvv { "123" }
    email { "test@example.com" }
    phone { "123-456-7890" }
  end
end
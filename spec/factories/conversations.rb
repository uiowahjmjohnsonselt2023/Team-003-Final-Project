FactoryBot.define do
  factory :conversation do
    sender { create(:user) }
    recipient { create(:user) }
  end
end
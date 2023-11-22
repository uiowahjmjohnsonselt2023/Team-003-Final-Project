FactoryBot.define do
  factory :message do
    association :sender, factory: :user
    association :receiver, factory: :user
    body { "Sample message text" }
  end
end
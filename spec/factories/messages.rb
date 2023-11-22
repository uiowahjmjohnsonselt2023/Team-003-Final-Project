FactoryBot.define do
  factory :message do
    body { "Hello there!" }
    conversation
    user { conversation.sender }
  end
end
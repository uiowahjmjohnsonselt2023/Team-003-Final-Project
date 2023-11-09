FactoryBot.define do
  factory :password_reset do
    association :user
    token { SecureRandom.urlsafe_base64 }
    created_at { Time.current }
  end
end

FactoryBot.define do
  factory :password_reset do
    user
    reset_token { SecureRandom.urlsafe_base64 }
    expires_at { 1.hour.from_now }
  end
end

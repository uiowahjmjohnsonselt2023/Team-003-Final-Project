FactoryBot.define do
  factory :admin, parent: :user do
    admin { true }
    username { "adminUser" }
    email { "admin@example.com" }
    password { "securepassword" }
    password_confirmation { "securepassword" }
  end
end
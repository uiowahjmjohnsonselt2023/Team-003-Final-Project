FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.username(specifier: 5..8) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    bio { Faker::Lorem.sentence }
    profile_picture { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/fixtures/profile_picture.jpg'), 'profile_picture.jpg') }
  end
end
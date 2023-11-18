FactoryBot.define do
  factory :category do
    name { ['Electronics', 'Books', 'Clothing', 'Toys', 'Furniture', 'Arts and Crafts', 'Kitchen Appliances'].sample }

    after(:build) do |category|
      file_path = Rails.root.join('spec', 'fixtures', 'files', 'generic_category_image.png')
      category.image.attach(io: File.open(file_path), filename: 'generic_category_image.png', content_type: 'image/png') if File.exists?(file_path)
    end
  end
end
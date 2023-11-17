# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.create(
  id: 1,
  title: 'Product Name',
  user_id: 1,
  condition: 'New',
  location: 'Default Location',
  price: 10.99,
  description: 'Product Description',
  created_at: Time.now,
  updated_at: Time.now
)

categories = {
  'Electronics' => 'electronics_icon.png',
  'Books' => 'books_icon.png',
  'Clothing' => 'clothing_icon.png',
  'Toys' => 'toys_icon.png',
  'Furniture' => 'furniture_icon.png'
}

categories.each do |name, filename|
  category = Category.find_or_create_by(name: name)

  file_path = Rails.root.join('app', 'assets', 'images', filename)
  if File.exists?(file_path)
    file = File.open(file_path)
    category.image.attach(io: file, filename: filename) if category.image.attached? == false
    file.close
  end
end
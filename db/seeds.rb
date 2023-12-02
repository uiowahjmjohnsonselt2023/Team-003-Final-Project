# Categories with associated image filenames
categories = {
  'Electronics' => 'electronics_icon.png',
  'Books' => 'books_icon.png',
  'Clothing' => 'clothing_icon.png',
  'Toys' => 'toys_icon.png',
  'Furniture' => 'furniture_icon.png',
  'Arts and Crafts' => 'arts_icon.png',
  'Kitchen Appliances' => 'kitchen_icon.png'
}

# create categories with images
categories.each do |name, filename|
  category = Category.find_or_create_by!(name: name)

  file_path = Rails.root.join('app', 'assets', 'images', filename)
  if File.exists?(file_path) && !category.image.attached?
    category.image.attach(io: File.open(file_path), filename: filename)
  end
end

# create multiple users and their products
10.times do
  user = User.create!(
    name: Faker::Name.unique.name,
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: "password"
  )

  # create products for each user
  5.times do
    product = user.products.create!(
      title: Faker::Commerce.product_name,
      description: "test description",
      price: Faker::Commerce.price(range: 10.0..100.0).round(2),
      condition: ['New', 'Used', 'Like New', 'Fair', 'Good', 'Poor'].sample,
      location: Faker::Address.city,
      category: Category.all.sample
    )
  end
end

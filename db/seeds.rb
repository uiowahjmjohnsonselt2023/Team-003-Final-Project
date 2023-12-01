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

# Create categories with images
categories.each do |name, filename|
  category = Category.find_or_create_by!(name: name)

  file_path = Rails.root.join('app', 'assets', 'images', filename)
  if File.exists?(file_path) && !category.image.attached?
    category.image.attach(io: File.open(file_path), filename: filename)
  end
end

# Create multiple users and their products/listings
5.times do |i|
  user = User.find_or_create_by!(username: "user#{i}", email: "user#{i}@example.com") do |new_user|
    new_user.name = "user#{i}"
    new_user.password = "password"
  end

  # Create products and listings for each user
  3.times do |j|
    product = user.products.create!(
      title: "Product #{j} by #{user.username}",
      condition: 'New',
      location: "Location",
      price: rand(10.0..100.0).round(2),
      description: "Description for product #{j} by #{user.username}",
      category: Category.all.sample
    )

    user.listings.create!(
      product: product,
      title: "Listing for #{product.title}",
      description: product.description,
      price: product.price,
      condition: product.condition,
      location: product.location,
      quantity: 10
    )
  end
end

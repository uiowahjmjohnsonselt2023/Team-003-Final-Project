# categories with associated image filenames
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
Faker::UniqueGenerator.clear
user = User.create(
  name:"John Admin",
  username: "admin123",
  email: "admin@admin.com",
  password: "password",
  admin: true
)
10.times do
  user = User.create!(
    name: Faker::Name.unique.name,
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: "password"
  )

  5.times do
    product = user.products.create!(
      title: Faker::Commerce.product_name,
      description: "test description",
      price: Faker::Commerce.price(range: 10.0..100.0).round(2),
      condition: ['New', 'Used', 'Like New', 'Fair', 'Good', 'Poor'].sample,
      location: Faker::Address.city,
      category: Category.all.sample,
      is_promoted: [true, false].sample,
      auction_enabled: false,
      starting_bid: 0,
      highest_bid: 0,
    )

rescue ActiveRecord::RecordInvalid => e
  puts "User creation failed: #{e.message}. Retrying..."
  retry
  end
end

User.limit(5).each do |user|
  cart = user.cart || user.create_cart
  cart.cart_items.destroy_all

  3.times do
    product = Product.all.sample
    cart.cart_items.create(product: product, quantity: [1, 2, 3].sample)
  end

  order = user.orders.new(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    postal_code: Faker::Address.zip,
    email: user.email,
    phone: Faker::PhoneNumber.phone_number,
    credit_card_number: '1234567890123456', # mock credit card number
    expiration_date: '11/21',               # mock expiration date
  )

  if order.save
    cart.cart_items.each do |cart_item|
      order.order_items.create(product: cart_item.product, quantity: cart_item.quantity)
    end

    order.create_tracking(
      tracking_number: SecureRandom.uuid,
      status: ['processing', 'shipped', 'delivered'].sample,
      shipping_carrier: ['UPS', 'FedEx', 'USPS'].sample
    )

    cart.cart_items.destroy_all
  else
    puts "Failed to create order for user #{user.id}: #{order.errors.full_messages.join(", ")}"
  end

  User.find_each do |user|
    user.products.each do |product|
      3.times do
        reviewer = User.where.not(id: user.id).sample
        Review.create!(
          product: product,
          reviewer: reviewer,
          reviewee: user,
          rating: rand(1..5),
          comment: Faker::Lorem.sentence
        )
      end
    end
  end
end
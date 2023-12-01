# create products for each user
User.all.each do |user|
  3.times do |i|
    product = user.products.create(
      title: "Product #{i} by #{user.username}",
      condition: 'New',
      location: "User #{user.id} Location",
      price: rand(10.0..100.0).round(2),
      description: "Description for product #{i} by #{user.username}"
      )

    # create listings for each product
    Listing.create(
      user_id: user.id,
      product_id: product.id,
      title: "Listing for #{product.title}",
      description: product.description,
      price: product.price,
      condition: product.condition,
      location: product.location
      )
  end
end

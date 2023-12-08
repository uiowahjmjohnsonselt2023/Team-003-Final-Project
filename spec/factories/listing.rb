FactoryBot.define do
  factory :listing do
    title { "Example Listing" }
    description { "This is an example listing description." }
    price { "100" }
    condition { "New" }
    quantity { 1 }
    user
    product

    # if includes an 'images' attribute:
    # images { "path_to_default_image.jpg" }
  end
end
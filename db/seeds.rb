require 'faker'
require 'open-uri'
require 'json'


Product.destroy_all
Category.destroy_all
Page.destroy_all
Province.destroy_all

Province.create!([
  { name: "Alberta", gst: 5, pst: 0, hst: 0 },
  { name: "British Columbia", gst: 5, pst: 7, hst: 0 },
  { name: "Manitoba", gst: 5, pst: 7, hst: 0 },
  { name: "New Brunswick", gst: 0, pst: 0, hst: 15 },
  { name: "Newfoundland and Labrador", gst: 0, pst: 0, hst: 15 },
  { name: "Northwest Territories", gst: 5, pst: 0, hst: 0 },
  { name: "Nova Scotia", gst: 0, pst: 0, hst: 15 },
  { name: "Nunavut", gst: 5, pst: 0, hst: 0 },
  { name: "Ontario", gst: 0, pst: 0, hst: 13 },
  { name: "Prince Edward Island", gst: 0, pst: 0, hst: 15 },
  { name: "Quebec", gst: 5, pst: 9.975, hst: 0 },
  { name: "Saskatchewan", gst: 5, pst: 6, hst: 0 },
  { name: "Yukon", gst: 5, pst: 0, hst: 0 }
])
puts "Seeding categories from scraped data..."
scraped_categories = ["Milestone", "Scraped Exclusive"]
scraped_categories.each do |name|
  Category.create!(name: name)
end

puts "Seeding products from scraped data..."
Product.create!(
  name: "Scraped Cotton Shirt",
  description: "Imported cotton shirt scraped from demo shop",
  price: 29.99,
  stock: 10,
  category: Category.find_by(name: "Milestone")
)


puts "Seeding products from FakeStoreAPI..."

api_url = "https://fakestoreapi.com/products"
response = URI.open(api_url).read
products = JSON.parse(response)

products.each do |item|
  category = Category.find_or_create_by!(name: item["category"])
  product = Product.new(
    name: item["title"],
    description: item["description"],
    price: item["price"],
    stock: rand(1..20),
    category: category
  )

  # Attach image if available
  if item["image"]
    file = URI.open(item["image"])
    product.image.attach(io: file, filename: "#{item['id']}.jpg")
  end

  product.save!
end


puts "Seeding categories and products with Faker..."

clothing_categories = [
  "T-Shirts", "Hoodies", "Jeans", "Jackets", "Dresses",
  "Accessories", "Sustainable Fashion", "Customizable Apparel",
  "Footwear", "Kids Wear", "Men's Wear", "Women's Wear"
]

clothing_categories.each do |cat_name|
  cat = Category.find_or_create_by!(name: cat_name)

  105.times do
    Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price(range: 20..100),
      stock: rand(1..30),
      category: cat
    )
  end
end


puts "Seeding About & Contact pages..."

Page.create!(
  title: 'About',
  body: 'Welcome to Patel Wears — where fashion meets sustainability. We are a Winnipeg-based clothing brand dedicated to offering modern, eco-conscious styles for everyday wear...'
)

Page.create!(
  title: 'Contact',
  body: 'We would love to hear from you! Whether you have a question about our products, your order, or just want to share feedback — feel free to reach out. Email: support@patelwears.com ...'
)


puts "Creating admin user..."
AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end

puts " Done seeding all data!"

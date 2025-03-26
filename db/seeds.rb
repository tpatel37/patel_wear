require 'faker'

# Clear existing records to avoid duplicates (optional, for dev only)
Category.destroy_all
Product.destroy_all
Page.destroy_all

# Clothing-related categories
category_names = [
  "T-Shirts", "Hoodies", "Jeans", "Jackets", "Dresses",
  "Accessories", "Sustainable Fashion", "Customizable Apparel",
  "Footwear", "Kids Wear", "Men's Wear", "Women's Wear"
]

# Create categories and products
category_names.each do |cat_name|
  cat = Category.create!(name: cat_name)

  # Add products to each category
  25.times do
    Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price(range: 20..100),
      stock: rand(1..30),
      category: cat
    )
  end
end

# Static Pages
Page.create!(title: 'About', body: 'This is the About page content for Patel Wears.')
Page.create!(title: 'Contact', body: 'This is the Contact page content for Patel Wears.')

# Admin user for development
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

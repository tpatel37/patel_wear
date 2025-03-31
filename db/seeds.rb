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
Page.create!(
  title: 'About',
  body: 'Welcome to Patel Wears — where fashion meets sustainability. We are a Winnipeg-based clothing brand dedicated to offering modern, eco-conscious styles for everyday wear. Our mission is to provide premium-quality, affordable clothing while promoting responsible fashion choices. Whether you’re shopping for timeless staples or trendy statement pieces, we’ve got something for everyone. Our team is passionate about bringing you styles that not only look good but also feel good — on your body and for the planet.'
)

Page.create!(
  title: 'Contact',
  body: 'We would love to hear from you! Whether you have a question about our products, your order, or just want to share feedback — feel free to reach out.

Email: support@patelwears.com  
Phone: +1 (204) 1234567
Business Hours: Monday to Friday - 9:00 AM to 6:00 PM (CST)  
Address: 123 Fashion Ave, Winnipeg, MB, Canada

Follow us on Instagram @patelwears for new arrivals, exclusive deals, and more!'
)
# Admin user for development
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

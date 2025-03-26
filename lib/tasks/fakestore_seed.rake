# lib/tasks/fakestore_seed.rake
require 'open-uri'
require 'json'

namespace :fakestore do
  desc "Seed products from FakeStore API"
  task seed: :environment do
    puts "Fetching products from FakeStoreAPI..."

    url = "https://fakestoreapi.com/products"
    response = URI.open(url).read
    products = JSON.parse(response)

    products.each do |item|
      next unless item["category"].include?("clothing")

      category = Category.find_or_create_by!(name: item["category"].titleize)

      Product.create!(
        name: item["title"],
        description: item["description"],
        price: item["price"],
        stock: rand(5..50),
        category: category
      )
    end

    puts "Seeding completed successfully!"
  end
end

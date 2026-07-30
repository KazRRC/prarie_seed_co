require "faker"
require "csv"

puts "Resetting database..."

OrderItem.destroy_all if defined?(OrderItem)
Order.destroy_all if defined?(Order)

Customer.destroy_all
Product.destroy_all
Category.destroy_all
Province.destroy_all

puts "Database cleared."

load Rails.root.join("db/seeds/provinces.rb")
load Rails.root.join("db/seeds/categories.rb")
load Rails.root.join("db/seeds/products.rb")
load Rails.root.join("db/seeds/customers.rb")

puts ""
puts "=============================="
puts "Database successfully seeded!"
puts "=============================="

puts "Provinces: #{Province.count}"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
puts "Customers: #{Customer.count}"

puts "New Products: #{Product.new_products.count}"
puts "On Sale: #{Product.on_sale.count}"
puts "Featured: #{Product.featured_products.count}"
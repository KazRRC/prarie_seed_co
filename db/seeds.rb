require "csv"
require "faker"

puts "Resetting database..."

Product.destroy_all
Category.destroy_all

vegetables = Category.create!(
  name: "Vegetable Seeds",
  description: "Vegetable seeds suitable for Manitoba gardens."
)

fruits = Category.create!(
  name: "Fruit Seeds",
  description: "Fruit seeds for home gardeners and small-scale growers."
)

flowers = Category.create!(
  name: "Flower Seeds",
  description: "Annual and perennial flower seeds for colourful gardens."
)

kits = Category.create!(
  name: "Gardening Kits",
  description: "Starter kits and gardening supplies for beginners."
)

categories = [vegetables, fruits, flowers, kits]

puts "Categories created"

SUN_VALUES = Product.sun_requirements.keys

def random_price
  rand(2.99..14.99).round(2)
end

def random_stock
  rand(10..150)
end

def random_sun
  Product.sun_requirements.keys.sample
end

def random_created_at
  rand(1.year.ago..7.days.ago)
end

def random_updated_at(created_at)
  rand(created_at..Time.current)
end

csv_path = Rails.root.join(
  "db",
  "data",
  "vegetables.csv"
)

if File.exist?(csv_path)
  puts "Importing..."

  CSV.foreach(csv_path, headers: true) do |row|
    price = random_price
    created = random_created_at
    updated = random_updated_at(created)

    product = Product.create!(
      name: row["VARIETY"]&.strip || Faker::Food.vegetables,
      description: "Premium Manitoba-ready vegetable seed variety for home gardens and raised beds.",
      price: price,
      stock_quantity: random_stock,
      category: vegetables,
      planting_depth: row["DEPTE TO PLANT"] || "1/4 inch",
      row_spacing: row["ROWS APART"] || "18-24 inches",
      plant_spacing: row["APART IN ROW"] || "4-12 inches",
      days_to_germination: [7, 10, 14, 21].sample.to_s,
      sun_requirements: random_sun,
      featured: [true, false, false, false].sample,
      on_sale: [true, false, false, false].sample,
      sale_price: nil,
      created_at: created,
      updated_at: updated
    )

    if product.on_sale?
      product.update!(
        sale_price: (price * rand(0.70..0.90)).round(2)
      )
    end
  end
end

puts "🥕 Vegetable products: #{Product.count}"


FRUIT_PRODUCTS = [
  "Sweet Strawberry Seeds",
  "Blueberry Garden Mix",
  "Prairie Raspberry Seeds",
  "Watermelon Heritage Seeds",
  "Cantaloupe Summer Seeds",
  "Dwarf Melon Collection",
  "Wild Berry Seed Blend"
]

FLOWER_PRODUCTS = [
  "Sunflower Giant Mix",
  "Prairie Wildflower Blend",
  "Butterfly Garden Mix",
  "Marigold Sunset Blend",
  "Zinnia Rainbow Collection",
  "Cosmos Summer Mix",
  "Daisy Meadow Blend",
  "Pollinator Paradise Seeds"
]

KIT_PRODUCTS = [
  "Beginner Herb Garden Kit",
  "Raised Bed Starter Kit",
  "Kids Garden Adventure Kit",
  "Organic Salad Garden Kit",
  "Container Tomato Kit",
  "Prairie Pollinator Garden Kit",
  "Balcony Vegetable Starter Kit",
  "Indoor Seed Starting Kit"
]


puts "Generating additional products with Faker..."

while Product.count < 90
  category = [fruits, flowers, kits, vegetables].sample

  name =
    case category
    when fruits
      FRUIT_PRODUCTS.sample
    when flowers
      FLOWER_PRODUCTS.sample
    when kits
      KIT_PRODUCTS.sample
    else
      "#{Faker::Food.vegetables} Seed Collection"
    end

  price = random_price
  created = random_created_at
  updated = random_updated_at(created)

  product = Product.create!(
    name: name,
    description: Faker::Marketing.buzzwords + " - Ideal for Manitoba gardeners and seasonal growing conditions.",
    price: price,
    stock_quantity: random_stock,
    category: category,
    planting_depth: ["1/8 inch", "1/4 inch", "1/2 inch", "1 inch"].sample,
    row_spacing: ["12 inches", "18 inches", "24 inches", "36 inches"].sample,
    plant_spacing: ["4 inches", "6 inches", "12 inches", "18 inches"].sample,
    days_to_germination: ["5-7 days", "7-10 days", "10-14 days", "14-21 days"].sample,
    sun_requirements: random_sun,
    featured: rand < 0.10,
    on_sale: rand < 0.20,
    sale_price: nil,
    created_at: created,
    updated_at: updated
  )

  if product.on_sale?
    product.update!(
      sale_price: (price * rand(0.70..0.90)).round(2)
    )
  end
end

Product.order("RANDOM()").limit(10).each do |product|
  time = Time.at(rand(2.days.ago.to_i..1.hour.ago.to_i))

  product.update_columns(
    created_at: time,
    updated_at: time
  )
end

eligible = Product.where("created_at < ?", 3.days.ago)

eligible.order("RANDOM()").limit(10).each do |product|
  product.update_columns(
    updated_at: Time.at(rand(2.days.ago.to_i..1.hour.ago.to_i))
  )
end

puts "complete!"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
puts "New products: #{Product.new_products.count}"
puts "Recently updated: #{Product.recently_updated.count}"
puts "On sale: #{Product.on_sale.count}"
puts "Featured: #{Product.featured_products.count}"
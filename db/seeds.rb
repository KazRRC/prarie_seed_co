require "httparty"

puts "Starting database seed..."

# -------------------------
# Create Categories
# -------------------------

category_names = [
  "Vegetables",
  "Flowers",
  "Herbs",
  "Grains"
]

category_names.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

puts "Categories created."


# -------------------------
# Import Plants from Trefle API
# -------------------------

puts "Importing plants from Trefle API..."

token = ENV["TREFLE_API_TOKEN"]

if token.nil?
  puts "ERROR: Missing TREFLE_API_TOKEN"
  exit
end


imported_count = 0


(1..5).each do |page|

  response = HTTParty.get(
    "https://trefle.io/api/v1/plants",
    query: {
      token: token,
      page: page
    }
  )


  unless response.success?
    puts "API request failed on page #{page}"
    next
  end


  plants = response.parsed_response["data"]


  plants.each do |plant|

    category = Category.find_by(
      name: category_names[imported_count % category_names.length]
    )


    product_name =
      plant["common_name"].presence ||
      plant["scientific_name"].presence ||
      "Unknown Plant"


product = Product.new(
  name: product_name,
  description: "Seed product imported from Trefle API.",
  price: rand(2.99..15.99).round(2),
  stock_quantity: rand(10..100),
  image_url: "https://placehold.co/600x400?text=#{product_name.parameterize}",
  category: category
)


    puts "Creating #{product.name}"
    puts "Description: #{product.description.inspect}"


    product.save!


    imported_count += 1

  end


  puts "Finished importing page #{page}"

end


puts "-------------------------"
puts "Seed complete!"
puts "Products: #{Product.count}"
puts "Categories: #{Category.count}"
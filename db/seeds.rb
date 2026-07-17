require "httparty"

puts "Importing plants from Trefle API..."

TOKEN = "usr-iqzSJ70aIAsfExcIZpv9McTWREr_KtDIkoHRb4OhgHg"

response = HTTParty.get(
  "https://trefle.io/api/v1/plants",
  query: {
    token: TOKEN
  }
)

plants = response.parsed_response["data"]


plants.each do |plant|

  category = Category.find_or_create_by!(
    name: "Seeds"
  )

Product.create!(
  name: plant["common_name"].presence || plant["scientific_name"] || "Unknown Plant",
  description: "Seed product imported from Trefle API.",
  price: rand(2.99..15.99).round(2),
  category: category
)

end

puts "Imported #{Product.count} products."
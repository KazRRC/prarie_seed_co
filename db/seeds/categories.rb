vegetables = Category.create!(
  name: "Vegetable Seeds",
  description: "Vegetable seeds suitable for Manitoba gardens."
)

fruits = Category.create!(
  name: "Fruit Seeds",
  description: "Fruit seeds for home gardeners."
)

flowers = Category.create!(
  name: "Flower Seeds",
  description: "Annual and perennial flower seeds."
)

kits = Category.create!(
  name: "Gardening Kits",
  description: "Starter kits and gardening supplies."
)

puts "✓ Categories created"
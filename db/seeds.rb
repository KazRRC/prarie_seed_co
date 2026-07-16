Category.destroy_all
Product.destroy_all

vegetables = Category.create!(
  name: "Vegetable Seeds",
  description: "Seeds for growing fresh vegetables."
)

fruits = Category.create!(
  name: "Fruit Seeds",
  description: "Seeds for growing delicious fruits."
)

flowers = Category.create!(
  name: "Flower Seeds",
  description: "Seeds for beautiful flowers."
)

Product.create!([
  {
    name: "Roma Tomato",
    description: "Excellent tomato for sauces.",
    price: 3.99,
    stock_quantity: 50,
    image_url: "https://picsum.photos/400?1",
    category: vegetables
      on_sale: true,
  sale_price: 2.99
  },
  {
    name: "Carrot Nantes",
    description: "Sweet orange carrots.",
    price: 2.99,
    stock_quantity: 80,
    image_url: "https://picsum.photos/400?2",
    category: vegetables
  },
  {
    name: "Cucumber Marketmore",
    description: "Perfect slicing cucumber.",
    price: 3.49,
    stock_quantity: 60,
    image_url: "https://picsum.photos/400?3",
    category: vegetables
  },
  {
    name: "Strawberry",
    description: "Juicy garden strawberries.",
    price: 4.99,
    stock_quantity: 40,
    image_url: "https://picsum.photos/400?4",
    category: fruits
  },
  {
    name: "Blueberry",
    description: "Hardy blueberry variety.",
    price: 4.49,
    stock_quantity: 30,
    image_url: "https://picsum.photos/400?5",
    category: fruits
  },
  {
    name: "Sunflower",
    description: "Large bright flowers.",
    price: 2.99,
    stock_quantity: 100,
    image_url: "https://picsum.photos/400?6",
    category: flowers
  },
  {
    name: "Marigold",
    description: "Colourful garden flowers.",
    price: 2.49,
    stock_quantity: 120,
    image_url: "https://picsum.photos/400?7",
    category: flowers
  }
])

puts "Seeded database successfully!"
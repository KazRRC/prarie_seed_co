require "csv"

puts "Clearing database..."

Product.destroy_all
Category.destroy_all

categories = {
  vegetables: Category.create!(
    name: "Vegetable Seeds",
    description: "Vegetable seeds for home gardens."
  ),

  fruits: Category.create!(
    name: "Fruit Seeds",
    description: "Fruit seeds for Manitoba growers."
  ),

  flowers: Category.create!(
    name: "Flower Seeds",
    description: "Annual and perennial flower seeds."
  ),

  kits: Category.create!(
    name: "Gardening Kits",
    description: "Starter kits and accessories."
  )
}

csv_path = Rails.root.join("db", "data", "vegetables.csv")

unless File.exist?(csv_path)
  abort "ERROR: Could not find #{csv_path}"
end

puts "Importing vegetables..."

CSV.foreach(csv_path, headers: true) do |row|

  Product.create!(
    name: row["VARIETY"]&.strip,
    description: <<~DESC,
      Planting Time: #{row["WHEN TO\nPLANT"]}

      Seeds or Plants per 100 ft Row:
      #{row["SEEDS OR PLANTS FOR\n100 FT. ROW"]}

      Row Spacing:
      #{row["ROWS APART"]}

      Plant Spacing:
      #{row["APART IN ROW"]}

      Planting Depth:
      #{row["DEPTE TO PLANT"]}
    DESC

    price: rand(2.99..8.99).round(2),

    stock_quantity: rand(15..100),

    image_url: "default-vegetable.jpg",

    category: vegetables,

    on_sale: [true, false].sample,

    sale_price: rand(1.99..6.99).round(2)
  )

end

puts "#{Product.count} products imported."

puts "Done!"
# lib/product_scraper.rb

require "open-uri"
require "nokogiri"

class ProductScraper
  def self.import
    url = "https://example.com"

    html = URI.open(url)
    doc = Nokogiri::HTML(html)

    doc.css(".product").each do |item|
      category = Category.find_or_create_by!(
        name: item.css(".category").text.strip
      )

      Product.create!(
        name: item.css(".title").text.strip,
        price: item.css(".price").text.delete("$").to_f,
        category: category
      )
    end
  end
end
require 'httparty'

class ProductApiJob
  include Sidekiq::Job

  def perform
    Rails.logger.info "Fetching products from API..."
    
    response = HTTParty.get("https://fakestoreapi.com/products")

    if response.code == 200
      products = response.parsed_response
      products.each do |item|
        Product.create!(
          name: item["title"],
          description: item["description"],
          price: item["price"].to_f,
          stock: rand(10..100)
        )
      end
      Rails.logger.info "Products imported successfully!"
    else
      Rails.logger.error "Failed to fetch products. Status: #{response.code}"
    end
  rescue => e
    Rails.logger.error "Product API Job failed: #{e.message}"
  end
end

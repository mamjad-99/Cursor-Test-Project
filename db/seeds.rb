# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Sample Orders Data
if Order.count.zero?
  orders_data = [
    {
      customer_name: "John Smith",
      freight: 25.50,
      ship_name: "Express Shipping",
      ship_country: "United States"
    },
    {
      customer_name: "Maria Garcia",
      freight: 15.75,
      ship_name: "Fast Delivery",
      ship_country: "Spain"
    },
    {
      customer_name: "David Johnson",
      freight: 32.00,
      ship_name: "Premium Shipping",
      ship_country: "Canada"
    },
    {
      customer_name: "Sarah Wilson",
      freight: 18.25,
      ship_name: "Standard Delivery",
      ship_country: "United Kingdom"
    },
    {
      customer_name: "Michael Brown",
      freight: 45.80,
      ship_name: "International Express",
      ship_country: "Australia"
    }
  ]

  orders_data.each do |order_attrs|
    Order.create!(order_attrs)
  end

  puts "✅ Created #{Order.count} sample orders"
end

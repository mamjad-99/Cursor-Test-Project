class Order < ApplicationRecord
  validates :customer_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :freight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :ship_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :ship_country, presence: true, length: { minimum: 2, maximum: 50 }
  
  # Custom method to format freight as currency
  def formatted_freight
    "$#{freight&.round(2)}"
  end
end

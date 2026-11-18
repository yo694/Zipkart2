class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product_variant

  validates :qty, numericality: {greater_than: 0}
  validates :price, numericality: {greater_than: 0}
  
end

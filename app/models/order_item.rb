class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_variant

  validates :qty, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
end

class Order < ApplicationRecord
  belongs_to :user

  validates :total_amount, numericality: {greater_than_or_equal_to: 0}

  enum :status,{
    pending: 0,
    confirmed: 1,
    shipped: 2,
    delivered: 3,
    cancelled: 4
  }
end

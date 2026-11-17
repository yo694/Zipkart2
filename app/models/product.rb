class Product < ApplicationRecord
  belongs_to :vendor

  has_many :product_variants, dependent: :destroy
  accepts_nested_attributes_for :product_variants, allow_destroy: true


  validates :product_name , presence: true
  validates :description, presence: true

  #Ruby hash
  scope :by_vendor, ->(vendor_id){
    where(vendor_id: vendor_id)
  }

  #Sql string
  scope :in_stock, ->{
    joins(:product_variants)
    .where("product_variants.available_qty > 0")
    .distinct
  }

  #Ruby range
  scope :within_price , ->(min_price,max_price){
    joins(:product_variants)
    .where(product_variants: { price: min_price..max_price})
    .distinct
  }
end

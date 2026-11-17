class ProductVariant < ApplicationRecord
  belongs_to :product

  validates :price , numericality: {greater_than: 0}, presence: true
  validates :total_qty ,numericality: {greater_than_or_equal_to: 0}, presence: true
  validates :available_qty, numericality: {greater_than_or_equal_to: 0 , less_than_or_equal_to: :total_qty  },presence: true

  validate :variant_attribute_present

  private 

  def variant_attribute_present
    if colour.blank? && size.blank? && model.blank?
      errors.add(:base, "At least one Product Variant attribute must be present!")
    end
  end

end

class AddIndexToProductsProductName < ActiveRecord::Migration[7.1]
  def change
    add_index :products, :product_name
  end
end
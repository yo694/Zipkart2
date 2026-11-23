class AddUniqueIndexToCartItems< ActiveRecord::Migration[7.1]
  def change
    add_index :cart_items,
              [:cart_id, :product_variant_id],
              unique: true
  end
end
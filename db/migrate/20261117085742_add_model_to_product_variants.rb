class AddModelToProductVariants < ActiveRecord::Migration[7.1]
  def change
    add_column :product_variants, :model, :string
  end
end

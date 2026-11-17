class CreateProductVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :product_variants do |t|
      t.references :product, null: false, foreign_key: true
      t.string :colour
      t.string :size
      t.decimal :price,precision: 10 , scale: 2 ,null: false
      t.integer :total_qty, null: false, default: 0
      t.integer :available_qty , null: false,default: 0

      t.timestamps
    end
  end
end

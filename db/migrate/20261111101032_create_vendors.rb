class CreateVendors < ActiveRecord::Migration[7.1]
  def change
    create_table :vendors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :bussiness_name
      t.text :bussiness_description
      t.string :gst_id

      t.timestamps
    end
  end
end

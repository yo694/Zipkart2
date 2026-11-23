class AddUniqueIndexToVendorsGstId < ActiveRecord::Migration[7.1]
  def change
        add_index :vendors, :gst_id, unique: true
  end
end

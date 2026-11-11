class MakeGstIdMandatoryOnVendors < ActiveRecord::Migration[7.1]
  def change
    change_column_null :vendors, :gst_id, false
  end
end

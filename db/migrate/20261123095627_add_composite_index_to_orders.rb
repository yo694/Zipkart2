class AddCompositeIndexToOrders < ActiveRecord::Migration[7.1]
  def change
    add_index :orders, [:user_id, :status]
  end
end
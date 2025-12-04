class AddSubtotalToOrderItems < ActiveRecord::Migration[8.1]
  def change
    add_column :order_items, :subtotal, :decimal
  end
end

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price_snapshot, presence: true, numericality: { greater_than: 0 }

  # Helper method to get line item total
  def line_total
    price_snapshot * quantity
  end

  def self.ransackable_associations(auth_object = nil)
    [ "order", "product" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "order_id", "price_snapshot", "product_id", "quantity", "updated_at" ]
  end
end

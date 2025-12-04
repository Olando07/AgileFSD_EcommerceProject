class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :user_id, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  # Helper method to get total items count
  def total_items
    order_items.sum(:quantity)
  end

  def self.ransackable_associations(auth_object = nil)
    [ "order_items", "products", "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "status", "total", "updated_at", "user_id", "name_snapshot", "subtotal", "gst", "pst", "hst" ]
  end
end

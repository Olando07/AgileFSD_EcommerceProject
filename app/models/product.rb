class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  has_one_attached :image
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "orders"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category", "created_at", "description", "id", "id_value", "name", "price", "updated_at"]
  end
end

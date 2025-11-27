class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  
  validates :user_id, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
end

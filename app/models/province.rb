class Province < ApplicationRecord
  has_many :users
  
  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :gst, presence: true, numericality: true
  validates :pst, presence: true, numericality: true
  validates :hst, presence: true, numericality: true
end

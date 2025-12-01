class Province < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :gst, presence: true, numericality: true
  validates :pst, presence: true, numericality: true
  validates :hst, presence: true, numericality: true

  def self.ransackable_associations(auth_object = nil)
    [ "users" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "abbreviation", "created_at", "gst", "hst", "id", "id_value", "name", "pst", "updated_at" ]
  end
end

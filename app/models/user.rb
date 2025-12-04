class User < ApplicationRecord
  belongs_to :province
  has_many :orders
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :street_address, presence: true
  validates :province_id, presence: true
  validates :is_admin, inclusion: { in: [ true, false ] }

  # Sets default is_admin to false
  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.is_admin ||= false
  end

   def self.ransackable_associations(auth_object = nil)
    [ "orders", "province" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "email", "id", "id_value", "is_admin", "name", "password_digest", "province_id", "street_address", "city", "postal_code", "telephone", "updated_at" ]
  end
end

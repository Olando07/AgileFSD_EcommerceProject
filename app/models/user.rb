class User < ApplicationRecord
  belongs_to :province
  has_many :orders
  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :street_address, presence: true
  validates :province_id, presence: true
  validates :is_admin, inclusion: { in: [true, false] }
  
  # Sets default is_admin to false
  after_initialize :set_defaults, if: :new_record?
  
  private
  
  def set_defaults
    self.is_admin ||= false
  end
end

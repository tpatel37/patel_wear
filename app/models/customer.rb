class Customer < ApplicationRecord
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  belongs_to :province
  has_many :orders
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true
  validates :province_id, presence: true


  
  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "email", "address", "province_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "province"]
  end
end
k
class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :province
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, paid: 1, shipped: 2 }, _prefix: :order
  validates :subtotal, :gst, :pst, :hst, :total, presence: true, numericality: true

 
  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items", "province"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "customer_id", "province_id", "status", "total", "created_at", "updated_at"]
  end
end
k
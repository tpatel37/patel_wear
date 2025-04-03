class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  
  scope :on_sale, -> { where("price < ?", 50) }

 
  scope :new_products, -> { where("created_at >= ?", 3.days.ago) }

  
  scope :recently_updated, -> { where("updated_at >= ?", 3.days.ago) }

  def self.ransackable_attributes(auth_object = nil)
    %w[name description price stock category_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category]
  end
end

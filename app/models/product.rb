class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[name description price stock created_at updated_at category_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category image_attachment image_blob]
  end
end

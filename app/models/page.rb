class Page < ApplicationRecord

    # Allow searchable fields for ActiveAdmin/Ransack
    def self.ransackable_attributes(auth_object = nil)
      ["body", "created_at", "id", "id_value", "title", "updated_at"]
    end
  
    def self.ransackable_associations(auth_object = nil)
      []  # or include any associations if needed
    end
  
  end
  
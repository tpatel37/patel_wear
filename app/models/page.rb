class Page < ApplicationRecord

  
    def self.ransackable_attributes(auth_object = nil)
      ["body", "created_at", "id", "id_value", "title", "updated_at"]
    end
  
    def self.ransackable_associations(auth_object = nil)
      []  
    end
  
  en
  
class AdminUser < ApplicationRecord
  # Devise modules (you probably already have this)
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :trackable

  # Allowlisting attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "email",
      "created_at",
      "updated_at",
      "sign_in_count",
      "current_sign_in_at",
      "last_sign_in_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end

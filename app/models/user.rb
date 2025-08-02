class User < ApplicationRecord
  has_many :products

  # Rails 8.0.2 compatible enum syntax
  enum :role, { user: "user", admin: "admin", moderator: "moderator" }

  # Set default role for new users
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= "user"
  end

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

class User < ApplicationRecord
  rolify
  has_many :products, dependent: :destroy

  # Rails 8.0.2 compatible enum syntax
  enum :role, { user: "user", admin: "admin", moderator: "moderator" }

  # Set default role for new users
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= "user"
  end

  after_create :assign_role
  def assign_role
    self.add_role(:user) if self.role.blank?
  end
  

def self.jwt_revoked?(playload,user)
  false
end
def self.revoke_jwt(playload,user)

end

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,jwt_revocation_strategy: self


end

class Product < ApplicationRecord
  validates :name,presence: true
  validates :description,presence:true
  belongs_to :user,optional: true
end

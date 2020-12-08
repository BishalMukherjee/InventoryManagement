class Category < ApplicationRecord
  has_many :brands
  has_many :items, through: :brands
  has_one :storage
  validates :name, presence: true, uniqueness: true
end

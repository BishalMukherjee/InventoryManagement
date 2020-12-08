class Brand < ApplicationRecord
  belongs_to :category, foreign_key: "category_id"
  has_many :items
  validates_presence_of :category_id
  validates :name, presence: true
end
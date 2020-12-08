class Issue < ApplicationRecord
  belongs_to :item, inverse_of: :issue, foreign_key: "item_id"
  validates :details, presence: true
  validates_presence_of :item_id
end
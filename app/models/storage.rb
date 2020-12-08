class Storage < ApplicationRecord
  after_save :create_notification

  belongs_to :category, foreign_key: "category_id"
  validates :category_id, presence: true, uniqueness: {message: "storage details already available."}
  validates :procurement_time, presence: true
  validates :total, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :buffer, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private
  def create_notification
    associated = self.category.items.count
    remaining = self.total - associated

    if remaining == 0
      Notification.create(notifiable_name: self.category.name, details: "is running short.", urgency: "danger", read_status: false)
    elsif (self.buffer)/2 >= remaining
      Notification.create(notifiable_name: self.category.name, details: "is running short.", urgency: "warning", read_status: false)
    elsif self.buffer == remaining
      Notification.create(notifiable_name: self.category.name, details: "is running short.", urgency: "secondary", read_status: false)
    end
  end
end
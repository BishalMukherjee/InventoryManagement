class Notification < ApplicationRecord
  scope :unread_notification, -> { where(read_status: false) }
end
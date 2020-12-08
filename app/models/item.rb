class Item < ApplicationRecord
  after_save :create_notification

  belongs_to :brand, foreign_key: "brand_id"
  belongs_to :employee, foreign_key: "employee_id", optional: true
  has_one :issue, inverse_of: :item, dependent: :destroy
  mount_uploader :document, DocumentUploader
  validates :name, presence: true, uniqueness: true
  validate :employee_id_validation
  validate :storage_validation, on: :create
  validates_presence_of :brand_id

  private
  def employee_id_validation
    unless self.employee_id.nil?
      unless validates_presence_of :employee
        errors.add(:employee_id, "Invalid employee")
      end
    end
  end
  
  def storage_validation
    unless self.brand.category.storage.blank?
      remaining = self.brand.category.storage.total - self.brand.category.items.count
      unless remaining > 0
        errors.add(:item, "not available in storage.")
      end
    else
      errors.add(:category, "doesn't have storage details.")
    end
  end

  def create_notification
    remaining = self.brand.category.storage.total - self.brand.category.items.count
    buffer = self.brand.category.storage.buffer

    if remaining == 0
      Notification.create(notifiable_name: self.brand.category.name, details: "is running short.", urgency: "danger", read_status: false)
    elsif (buffer)/2 >= remaining
      Notification.create(notifiable_name: self.brand.category.name, details: "is running short.", urgency: "warning", read_status: false)
    elsif buffer == remaining
      Notification.create(notifiable_name: self.brand.category.name, details: "is running short.", urgency: "secondary", read_status: false)
    end
  end
end
class Admin < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :name, presence: true

  def self.sign_in_from_omniauth(mail)
    find_by( email: mail)
  end
end
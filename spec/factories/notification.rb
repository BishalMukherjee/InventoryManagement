FactoryBot.define do
  factory :notification do
    notifiable_name { "Category name" }
    details { "is running short." }
    urgency { "danger" }
    read_status { false }
  end
end
FactoryBot.define do
  factory :admin do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    provider { "google_oauth2" }
    brand_access { true }
    category_access { true }
    item_access { true }
    employee_access { true }
    storage_access { true }
    admin_access { true }

    factory :first_admin do
      name { "Bishal Mukherjee" }
      email { "bishalmukherjee7@gmail.com" }
    end

    factory :invalid_admin do
      name { nil }
    end
  end
end
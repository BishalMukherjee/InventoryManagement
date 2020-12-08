FactoryBot.define do
  factory :storage do
    total { 10 }
    buffer { 4 }
    procurement_time { Faker::Date.backward }
    category { association :category }

    factory :invalid_storage do
      category_id { nil }
    end
  end
end
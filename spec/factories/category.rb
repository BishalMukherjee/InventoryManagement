FactoryBot.define do
  factory :category do
    name { Faker::Name.name }

    factory :invalid_category do
      name { nil }
    end
  end
end
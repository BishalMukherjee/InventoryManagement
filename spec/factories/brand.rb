FactoryBot.define do
  factory :brand do
    name { Faker::Name.name }
    category { association :category }

    factory :brand_with_items do
      transient do
        items_count { 4 }
      end

      after(:create) do |brand, evaluator|
        create_list(:item, evaluator.items_count, brand: brand, category: category)
        brand.reload
      end
    end

    factory :invalid_brand do
      name { nil }
    end
  end
end
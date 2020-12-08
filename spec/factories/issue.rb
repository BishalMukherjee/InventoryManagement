FactoryBot.define do
  factory :issue do
    details { Faker::Lorem.paragraph }
    status { false }
    item { association :item }

    factory :invalid_issue do
      details { nil }
    end
  end
end
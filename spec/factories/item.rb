FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    status { true }
    notes { Faker::Lorem.sentence }
    document { fixture_file_upload 'spec/fixtures/dummy.pdf', 'document.pdf' }
    brand { association :brand }
    employee { association :employee }

    factory :invalid_item do
      name { nil }
    end

    factory :unassigned_item do
      employee { nil }
    end
  end
end
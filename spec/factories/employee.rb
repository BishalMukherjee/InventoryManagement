FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    status { true }

    factory :employee_with_items do
      transient do
        items_count { 4 }
      end

      after(:create) do |employee, evaluator|
        create_list(:post, evaluator.items_count, employee: employee)
        employee.reload
      end
    end

    factory :inactive_employee do
      status { false }
    end

    factory :invalid_employee do
      name { nil }
    end
  end
end
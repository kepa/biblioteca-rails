# frozen_string_literal: true

FactoryBot.define do
  factory :rental do
    active { true }
    late { false }
    checkout_date { ::Faker::Date.in_date_period }

    trait :returned do
      active { false }
    end
  end
end

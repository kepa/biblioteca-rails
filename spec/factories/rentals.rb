FactoryBot.define do
  factory :rental do
    active { true }
    late { false }
    checkout_date { ::Faker::Date.in_date_period }

    trait :returned do
      active { false }
    end

    trait :checked_out_2_days_ago do
      checkout_date {Time.now - 2.days}
    end

  end
end

FactoryBot.define do
  factory :book do
    title { ::Faker::Book.title }
    author { ::Faker::Book.author }
    category { ::Faker::Book.genre }

    trait :checked_out do
      check_out { true }
    end
  end
end

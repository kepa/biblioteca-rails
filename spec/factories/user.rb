# frozen_string_literal: true

FactoryBot.define do
  factory :user do

    name { ::Faker::Name.first_name }
    email { ::Faker::Internet.email }
    password { ::Faker::Alphanumeric.alpha(number: 6) }
  end
end

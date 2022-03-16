# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    name { SecureRandom.hex(15) }
    description { Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false) }
    privacy { 'public' }
    association :user, :confirmed

    trait :invalid do
      name { nil }
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :board_section do
    name { SecureRandom.hex(15) }
    description { Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false) }
    association :board

    trait :invalid do
      name { nil }
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    bio { Faker::Lorem.paragraph_by_chars(number: 160) }
    user

    trait :avatar_crop do
      association :avatar_crop, factory: :crop
    end
  end
end

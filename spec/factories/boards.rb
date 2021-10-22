# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    name { SecureRandom.hex(15) }
    privacy { 'public' }
    association :user, :confirmed

    trait :invalid do
      name { nil }
    end
  end
end

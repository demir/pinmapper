# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    username { SecureRandom.hex(15) }
    password { '123456' }
    password_confirmation { '123456' }

    trait :confirmed do
      confirmed_at { Time.zone.now }
      confirmation_sent_at { Time.zone.now }
      confirmation_token { srand.to_s.last(5) }
    end
  end
end

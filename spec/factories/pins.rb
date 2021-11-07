# frozen_string_literal: true

FactoryBot.define do
  factory :pin do
    name { Faker::Lorem.paragraph_by_chars(number: 128) }
    address { 'Samsun, Türkiye' }
    cover_image_description { Faker::Lorem.paragraph_by_chars(number: 500) }
    association :user, :confirmed
    # SecureRandom.hex(30).scan(/.{1,20}/) -> 3 words
    tag_list { SecureRandom.hex(30).scan(/.{1,20}/).join(',') }
    description { Faker::Lorem.paragraph_by_chars(number: 500) }

    trait :invalid do
      address { 'FooBooFooFFFooBooFooFF' }
      # SecureRandom.hex(45).scan(/.{1,15}/) -> 6 words
      tag_list { SecureRandom.hex(45).scan(/.{1,15}/).join(',') }
    end

    trait :cover_image_crop do
      association :cover_image_crop, factory: :crop
    end
  end
end

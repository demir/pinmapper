# frozen_string_literal: true

FactoryBot.define do
  factory :pin do
    name { Faker::Lorem.sentence(word_count: 4) }
    address { 'Samsun, Türkiye' }
    cover_photo_description { Faker::Lorem.paragraph_by_chars(number: 500) }
    association :user, :confirmed
    # SecureRandom.hex(30).scan(/.{1,20}/) -> 3 words
    tag_list { SecureRandom.hex(30).scan(/.{1,20}/).join(',') }
    description { Faker::Lorem.paragraph_by_chars(number: 500) }

    trait :invalid do
      address { 'FooBooFooFFFooBooFooFF' }
      # SecureRandom.hex(45).scan(/.{1,15}/) -> 6 words
      tag_list { SecureRandom.hex(45).scan(/.{1,15}/).join(',') }
    end

    trait :cover_photo_crop do
      association :cover_photo_crop, factory: :crop
    end
  end
end

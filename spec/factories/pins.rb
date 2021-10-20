# frozen_string_literal: true

FactoryBot.define do
  factory :pin do
    name { Faker::Address.city }
    address { 'Samsun, Türkiye' }
    cover_image_description { Faker::Lorem.paragraph }
    association :user, :confirmed
    # SecureRandom.hex(30).scan(/.{1,20}/) -> 3 words
    tag_list { SecureRandom.hex(30).scan(/.{1,20}/).join(',') }
    description { Faker::Lorem.paragraph }

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

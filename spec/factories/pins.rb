# frozen_string_literal: true

FactoryBot.define do
  factory :pin do
    name { Faker::Address.city }
    address { 'Samsun, Türkiye' }
    privacy { 'public' }
    cover_image_description { Faker::Lorem.paragraph }
    association :user, :confirmed
    tag_list { Faker::Lorem.unique.words(number: 3).join(',') }
    description { Faker::Lorem.paragraph }

    trait :invalid do
      address { 'FooBooFooFFFooBooFooFF' }
      tag_list { Faker::Lorem.unique.words(number: 6).join(',') }
    end

    trait :cover_image_crop do
      association :cover_image_crop, factory: :crop
    end
  end
end

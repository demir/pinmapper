# frozen_string_literal: true

FactoryBot.define do
  factory :crop do
    crop_x { Faker::Number.within(range: 1..400).to_s }
    crop_y { Faker::Number.within(range: 1..400).to_s }
    crop_width { Faker::Number.within(range: 1..400).to_s }
    crop_height { Faker::Number.within(range: 1..400).to_s }
    for_pin
    trait :for_pin do
      association :cropable, factory: :pin
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :embed do
    trait :video do
      url { 'https://www.youtube.com/watch?v=mpWFrUwAN88' }
    end

    trait :not_video do
      url { 'https://flic.kr/p/sbV9Qm' }
    end
  end
end

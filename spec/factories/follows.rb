# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    association :follower, factory: %i[user confirmed]
    association :following, factory: %i[user confirmed]
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :user_tag do
    association :user, :confirmed
    association :tag
  end
end

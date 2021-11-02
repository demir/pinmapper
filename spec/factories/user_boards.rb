# frozen_string_literal: true

FactoryBot.define do
  factory :user_board do
    association :user
    association :board
  end
end

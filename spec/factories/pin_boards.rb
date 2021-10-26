# frozen_string_literal: true

FactoryBot.define do
  factory :pin_board do
    association :pin
    association :board
  end
end

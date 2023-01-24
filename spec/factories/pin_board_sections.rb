# frozen_string_literal: true

FactoryBot.define do
  factory :pin_board_section do
    association :pin
    association :board_section
  end
end

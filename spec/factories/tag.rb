# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { SecureRandom.hex(14) }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :embed do
    url { 'MyString' }
    video { false }
    html { 'MyText' }
    thumbnail_url { 'MyString' }
  end
end

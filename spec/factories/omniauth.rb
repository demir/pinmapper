# frozen_string_literal: true

FactoryBot.define do
  factory :auth_hash, class: 'OmniAuth::AuthHash' do
    initialize_with do
      OmniAuth::AuthHash.new({ provider: provider,
                               uid:      uid,
                               info:     { name: name, email: email, image: image } })
    end

    trait :google do
      provider { 'google' }
      sequence(:uid)
      name { 'Foo Boog' }
      email { 'testuser@gmail.com' }
      image { 'https://via.placeholder.com/150' }
    end

    trait :facebook do
      provider { 'facebook' }
      sequence(:uid)
      name { 'Foo Boof' }
      email { 'testuser@facebook.com' }
      image { 'https://via.placeholder.com/150' }
    end

    trait :does_not_persist do
      name { '' }
      email { '' }
      image { '' }
    end
  end
end

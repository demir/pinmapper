FactoryBot.define do
  factory :follow do
    association :follower, factory: [:user, :confirmed]
    association :following, factory: [:user, :confirmed]
  end
end

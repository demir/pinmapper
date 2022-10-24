FactoryBot.define do
  factory :board_section do
    name { "MyString" }
    board { nil }
    pins_count { 1 }
    slug { "MyString" }
    position { 1 }
  end
end

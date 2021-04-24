FactoryBot.define do
  factory :crop do
    cropable_id { 1 }
    cropable_type { "MyString" }
    crop_x { "MyString" }
    crop_y { "MyString" }
    crop_width { "MyString" }
    crop_height { "MyString" }
  end
end

FactoryBot.define do
  factory :pin do
    name { "MyString" }
    address { "MyString" }
    latitude { "9.99" }
    longitude { "9.99" }
    privacy { 1 }
    cover_image_description { "MyText" }
  end
end

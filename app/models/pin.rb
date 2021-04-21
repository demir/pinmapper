class Pin < ApplicationRecord
  include TranslateEnum

  # enums
  enum category: { food: 0, coffee: 1, nightlife: 2, fun: 3, shopping: 4 }
  enum privacy: { private: 0, public: 1 }, _suffix: true

  translate_enum :category
  translate_enum :privacy
end

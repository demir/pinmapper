class Crop < ApplicationRecord
  belongs_to :cropable, polymorphic: true
end

# frozen_string_literal: true

class UserTag < ApplicationRecord
  belongs_to :user
  belongs_to :tag
end

# frozen_string_literal: true

class Pins::TagListComponent < ViewComponent::Base
  def initialize(tag_list:)
    @tag_list = tag_list
  end
end

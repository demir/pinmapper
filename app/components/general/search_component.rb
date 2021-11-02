# frozen_string_literal: true

module General
  class SearchComponent < ViewComponent::Base
    attr_reader :path, :current_user

    def initialize(path:, current_user:)
      @path = path
      @current_user = current_user
    end
  end
end

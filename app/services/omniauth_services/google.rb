# frozen_string_literal: true

module OmniauthServices
  class Google < ApplicationService
    include Common
    attr_reader :auth

    def initialize(auth)
      @auth = auth
    end

    def call
      raise ArgumentError if auth.blank?

      user = find_or_create_user(auth['info'])
    rescue StandardError => e
      { success: false, error: e }
    else
      { success: true, payload: user }
    end
  end
end

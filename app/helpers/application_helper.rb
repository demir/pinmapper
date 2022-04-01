# frozen_string_literal: true

module ApplicationHelper
  def app_url(path = nil)
    domain = Rails.application.credentials.domain
    return domain if path.nil?

    "#{domain}/#{path}"
  end
end

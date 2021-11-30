# frozen_string_literal: true

module OmniauthServices
  class Google < ApplicationService
    attr_reader :auth

    def initialize(auth)
      @auth = auth
    end

    def call
      raise ArgumentError if auth.blank?

      user = find_or_create_user
    rescue StandardError => e
      { success: false, error: e }
    else
      { success: true, payload: user }
    end

    private

    def find_or_create_user
      data = auth['info']
      user = User.find_by(email: data['email'])
      return user if user.present?

      create_user
    end

    def create_user
      data = auth['info']
      user = User.create(
        email:        data['email'],
        password:     Devise.friendly_token[0, 20],
        username:     temp_username(data['name']),
        confirmed_at: DateTime.now
      )
      downloaded_image = Down.download(data['image']) if data['image'].present?
      user.profile.avatar.attach(io: downloaded_image, filename: user.username) if downloaded_image.present?
      user
    end

    def temp_username(name)
      raw_username = name&.parameterize(separator: ' ')&.gsub(/[^a-z0-9_]/i, '')&.delete(' ')
      return if raw_username.blank?

      generate_username(raw_username)
    end

    def generate_username(raw_username)
      return raw_username.last(30) unless User.exists?(username: raw_username)

      generate_username(raw_username + rand(1000).to_s)
    end
  end
end

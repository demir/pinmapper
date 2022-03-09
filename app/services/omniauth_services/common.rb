module OmniauthServices
  module Common
    def find_or_create_user(data)
      user = User.find_by(email: data['email'])
      return user if user.present?

      create_user(data)
    end

    def create_user(data)
      User.create(
        email:        data['email'],
        password:     Devise.friendly_token[0, 20],
        username:     temp_username(data['name']),
        confirmed_at: DateTime.now
      )
    end

    def temp_username(name)
      raw_username = name&.parameterize(separator: ' ')&.gsub(/[^a-z0-9_]/i, '')&.delete(' ')
      return if raw_username.blank?

      generate_username(raw_username)
    end

    def generate_username(raw_username)
      return raw_username.last(30) if !User.exists?(username: raw_username) && ReservedWords.all.exclude?(raw_username)

      generate_username(raw_username + rand(1000).to_s)
    end
  end
end

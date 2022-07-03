require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pinmapper
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.exceptions_app = routes
    config.active_record.schema_format = :sql
    config.time_zone = 'Istanbul'
    config.i18n.available_locales = %i[en tr]
    config.i18n.default_locale = :en
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # After-initialize checker to add routes to reserved words
    config.after_initialize do
      # Add routes to reserved words
      Rails.application.reload_routes!
      top_routes = Rails.application.routes.routes.each_with_object([]) do |route, top_routes|
        route = route.path.spec.to_s
        route = route&.gsub('(/:locale)', '')
        route = route&.gsub('(.:format)', '')

        top_routes << route.split('/')
      end
      ReservedWords.all = [ReservedWords::BASE_WORDS + top_routes].flatten.compact.uniq
                                                                  .reject { |r| r.starts_with?(':') }
    end
  end
end

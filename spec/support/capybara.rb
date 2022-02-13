# frozen_string_literal: true

require 'webdrivers/chromedriver'
Webdrivers::Chromedriver.required_version = '97.0.4692.71'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Capybara::DSL

  Capybara.server = :puma, { Silent: true }

  # Chrome non-headless driver
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  # Chrome headless driver
  Capybara.register_driver :headless_chrome do |app|
    caps = Selenium::WebDriver::Remote::Capabilities.chrome('goog:loggingPrefs': { browser: 'ALL' })
    opts = Selenium::WebDriver::Chrome::Options.new

    chrome_args = %w[--headless --no-sandbox --disable-gpu --window-size=1920,1080 --remote-debugging-port=9222
                     --disable-dev-shm-usage --disable-popup-blocking --auto-open-devtools-for-tabs]
    chrome_args.each { |arg| opts.add_argument(arg) }
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts, desired_capabilities: caps)
  end
end

require 'spec_helper'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'headless'
require 'webdrivers/chromedriver'

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.filter_rails_from_backtrace!
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  options.add_preference(
    :download,
    directory_upgrade: true,
    prompt_for_download: false,
    default_directory: DownloadHelpers::PATH.to_s
  )

  chrome_args = %w[--no-sandbox --disable-gpu --window-size=1920,1080]
  chrome_args << '--headless' if ENV['BUDDY_CI']

  chrome_args.each { |arg| options.add_argument(arg) }

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

Capybara.javascript_driver = :headless_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
  config.match = :prefer_exact
  config.server = :webrick
  config.server_host = 'localhost'
  config.server_port = 9887 + ENV['TEST_ENV_NUMBER'].to_i
end

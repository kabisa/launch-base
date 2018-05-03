require "capybara/rspec"
require "selenium/webdriver"
require "capybara-screenshot/rspec"

RSpec.configure do |config|
  config.before :each do |example|
    Capybara.register_driver :selenium_chrome_headless do |app|
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        chromeOptions: { args: %w(headless disable-gpu no-sandbox window-size=1400,1200) },
        loggingPrefs:{ browser: 'ALL' }
      )

      Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
    end

    Capybara.register_driver :selenium_chrome do |app|
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        chromeOptions: { args: %w(disable-gpu no-sandbox window-size=1400,1200) }
      )

      Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
    end

    Capybara.current_driver = if example.metadata[:js]
                                example.metadata[:headless] === false ? :selenium_chrome : :selenium_chrome_headless
                              else
                                :rack_test
                              end
  end
end

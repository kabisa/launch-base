RSpec.configure do |config|
  config.after :each, js: true do
    errors = page.driver.browser.manage.logs.get(:browser).select { |log| log.level == 'SEVERE' }

    if errors.any?
      report = errors.map { |error| error.message.gsub('\\n', '\n') }.join("\n\n")
      raise "There were #{errors.count} JavaScript errors:\n\n#{report}"
    end
  end
end

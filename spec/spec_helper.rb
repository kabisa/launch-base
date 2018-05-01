require 'simplecov'
SimpleCov.start

require 'bundler/setup'
require 'launch_base'
require './spec/support/launch_base'

Dir[Pathname.new(__dir__).join('support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expose_dsl_globally = true

  config.include LaunchBaseTestHelpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

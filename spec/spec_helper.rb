require 'bundler/setup'
require 'launch_base'
require './spec/support/launch_base'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.include LaunchBaseTestHelpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

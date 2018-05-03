require "database_cleaner"

RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.around :each do |example|
    DatabaseCleaner.strategy = if example.metadata[:type].in? [:feature, :request]
                                 :truncation
                               else
                                 :transaction
                               end

    DatabaseCleaner.start
    example.run
    DatabaseCleaner.clean
  end
end

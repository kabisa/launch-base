# Kabisa LaunchBase :rocket:

[![Build Status](https://travis-ci.org/kabisa/launch-base.svg?branch=master)](https://travis-ci.org/kabisa/launch-base)
[![Maintainability](https://api.codeclimate.com/v1/badges/f563fdb89d5509e4e8f3/maintainability)](https://codeclimate.com/github/kabisa/launch-base/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/f563fdb89d5509e4e8f3/test_coverage)](https://codeclimate.com/github/kabisa/launch-base/test_coverage)

## Installation

### In an existing Rails application

Add this line to your application's Gemfile:

```ruby
gem 'launch_base'
```

And then execute:

    bundle

Or install it yourself as:

    gem install launch_base

### Globally, to generate a new application:

    sudo gem install launch_base

## Usage

```
launch_base add sidekiq         # Add Sidekiq gem and configuration to your app
launch_base help [COMMAND]      # Describe available commands or one specific command
launch_base new                 # Create a new LaunchBase project (Rails 5.1 or higher is required)
launch_base new --with-sidekiq  # Create a new LaunchBase project including Sidekiq support
launch_base update              # update LaunchBase
launch_base lint install        # install lint configuration files
launch_base lint update         # update gem and reinstall lint configuration files
```

## Requirements

### Database transactions

An app generated by Launch Base assumes database transactions work within Capybara tests, which requires Rails 5.1 or
higher. Alternatively, you should add `DatabaseCleaner`:

1. Add `DatabaseCleaner` to your gem within the `test` group (be sure to also run `bundle install`):

```ruby
group :test do
  gem 'database_cleaner'
end
```

2. Add a `spec/support/database_cleaner.rb` file:

```ruby
require 'database_cleaner'

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
```

## Contents

For info about the contents of an app generated by LaunchBase, please refer to the
[`README.md` template](templates/README.md.erb)

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake test` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`,
and then run `bundle exec gem tag --push`, which will create and ush a git tag for the version. 
Travis CI will automatically build and publish the gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at [Launch Base](https://github.com/kabisa/launch-base).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

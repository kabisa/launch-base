require_relative '../lib/Launch_base'
# Launch Base default template file
def source_paths
  Array(super) + [File.expand_path(File.dirname(__FILE__))]
end

remove_file 'Gemfile'
run 'touch Gemfile'
add_source 'https://rubygems.org'

gem 'rails', "#{LaunchBase::RAILS_VERSION}"

gem 'pg'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

gem_group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.7'
end

gem_group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem_group :test do
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

remove_file '.ruby-version'
copy_file '.ruby-version'

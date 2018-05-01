# Launch Base default template file
def source_paths
  Array(super) + [__dir__]
end

say 'Removing and setting up Gemfile for new project'
remove_file 'Gemfile'
run 'touch Gemfile'
add_source 'https://rubygems.org'

gem 'rails', '5.2.0'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'bootsnap', '>= 1.1.0', require: false

gem_group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.7'
end

gem_group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'listen'
end

gem_group :test do
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'fuubar'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

say 'Adding .ruby-version file to project'
remove_file '.ruby-version'
copy_file '.ruby-version'

say 'Adding README.md file to project'
remove_file 'README.md'
copy_file 'README.md'

remove_file 'config/database.yml'
template 'database.erb', 'config/database.yml'

after_bundle do
  run 'spring stop'
  bundle_command 'exec rails g rspec:install'

  remove_file '.rspec'
  copy_file '.rspec'

  run 'mkdir -p spec/features \
             spec/models \
             spec/factories \
             spec/requests \
             spec/support \
             spec/fixtures'

  run 'rm -rf test'
  copy_file 'ping_spec.rb', 'spec/requests/ping_spec.rb'

  insert_into_file 'config/routes.rb', after: "Rails.application.routes.draw do\n" do
    "  get '/ping', to: ->(_env) { [200, {}, ['pong']]}"
  end

  bundle_command 'exec rake db:drop'
  bundle_command 'exec rake db:create'
  bundle_command 'exec rake db:migrate'
end

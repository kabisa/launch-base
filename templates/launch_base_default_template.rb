require 'redcarpet'

# Launch Base default template file
def source_paths
  fixtures_directory = Pathname.new(__dir__).join('..', 'spec', 'fixtures')
  [__dir__, fixtures_directory] + Array(super)
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
gem 'turbolinks', '~> 5'

gem_group :development, :test do
  gem 'pry'
  gem 'factory_bot_rails'
end

gem_group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'listen'
end

gem_group :test do
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'capybara-selenium'
  gem 'capybara-screenshot'
  gem 'simplecov'
  gem 'fuubar'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'rspec-rails', '~> 3.7'
end

say 'Adding .ruby-version and .ruby-gemset file to project'
remove_file '.ruby-version'
copy_file '.ruby-version', '.ruby-version'
copy_file '.ruby-gemset', '.ruby-gemset'

copy_file '.codeclimate.yml', '.codeclimate.yml'
copy_file '.eslintrc.json', '.eslintrc.json'
copy_file '.mdlrc', '.mdlrc'
copy_file '.rubocop.yml', '.rubocop.yml'
copy_file 'config.reek', 'config.reek'

say 'Adding README.md file to project'
remove_file 'README.md'
copy_file 'README.md', 'README.md'

remove_file 'config/database.yml'
template 'config/database.yml.erb', 'config/database.yml'

copy_file 'app.json', 'app.json'
copy_file 'bin/ci', 'bin/ci'
run 'chmod +x bin/ci'
copy_file 'bin/post_deploy', 'bin/post_deploy'
copy_file 'dockerfiles/ci/Dockerfile', 'dockerfiles/ci/Dockerfile'
copy_file 'Jenkinsfile', 'Jenkinsfile'

uncomment_lines 'config/environments/development.rb', 'config.action_view.raise_on_missing_translations = true'
uncomment_lines 'config/environments/test.rb', 'config.action_view.raise_on_missing_translations = true'
gsub_file 'config/environments/production.rb', 'config.log_level = :debug', 'config.log_level = :info'

after_bundle do
  run 'spring stop'
  bundle_command 'exec rails g rspec:install'

  remove_file '.rspec'
  copy_file '.rspec', '.rspec'

  run 'mkdir -p spec/features \
             spec/models \
             spec/factories \
             spec/requests \
             spec/support \
             spec/fixtures'

  copy_file 'spec/support/capybara.rb', 'spec/support/capybara.rb'
  copy_file 'spec/support/factory_bot.rb', 'spec/support/factory_bot.rb'
  copy_file 'spec/support/feature_spec_helpers.rb', 'spec/support/feature_spec_helpers.rb'
  copy_file 'spec/support/spec_helpers.rb', 'spec/support/spec_helpers.rb'

  remove_file 'spec/rails_helper.rb'
  copy_file 'spec/rails_helper.rb', 'spec/rails_helper.rb'

  run 'rm -rf test'

  copy_file 'spec/requests/ping_spec.rb', 'spec/requests/ping_spec.rb'
  copy_file 'spec/features/homepage_spec.rb', 'spec/features/homepage_spec.rb'
  copy_file 'app/controllers/homepage_controller.rb', 'app/controllers/homepage_controller.rb'

  insert_into_file 'config/routes.rb', after: "Rails.application.routes.draw do\n" do
    <<-ROUTES
      get '/ping', to: ->(_env) { [200, {}, ['pong']]}
      root to: 'homepage#show'
    ROUTES
  end

  create_file 'app/views/homepage/show.html.erb' do
    markdown_renderer = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(link_attributes: { target: '_blank' }),
      autolink: true,
      tables: true
    )

    markdown = File.read('README.md')
    markdown_renderer.render(markdown)
  end

  if ENV['INCLUDE_TESTING_FILES'] == '1'
    insert_into_file 'config/routes.rb', after: "Rails.application.routes.draw do\n" do
      <<-ROUTES
        resource :kabisians, only: [:show]
      ROUTES
    end

    copy_file 'controllers/kabisians_controller.rb', 'app/controllers/kabisians_controller.rb'
    copy_file 'models/kabisian.rb', 'app/models/kabisian.rb'
    copy_file 'views/kabisians/show.html.erb', 'app/views/kabisians/show.html.erb'
    copy_file 'spec/factories/kabisians.rb', 'spec/factories/kabisians.rb'
    copy_file 'spec/features/kabisians_spec_.rb', 'spec/features/kabisians_spec.rb'
    bundle_command 'exec rails generate migration CreateKabisians name:string'
  end

  bundle_command 'exec rake db:drop'
  bundle_command 'exec rake db:create'
  bundle_command 'exec rake db:migrate'
end
